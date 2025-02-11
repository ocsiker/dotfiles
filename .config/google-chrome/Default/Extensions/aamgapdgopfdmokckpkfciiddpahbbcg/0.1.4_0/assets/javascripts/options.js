class OptionsPage {

  constructor() {
    this.options = {};
    this.categoriesNode = document.querySelector('.categories');
    this.newCategoryNode = document.querySelector('.new.category');
    this.ratingPromptNode = document.querySelector('.rating-prompt');
    this.editedCategoryNode = null;
    this.editedCategory = null;
    this.selectedCategoryNode = null;
    this.justSavedCategory = false;
    this.categoryTemplate = document.querySelector('#category-template').content;
    this.editableCategoryTemplate = document.querySelector('#editable-category-template').content;

    this.addCategoryListeners(this.newCategoryNode);
    this.addInputsListener(this.newCategoryNode);
    autosize(this.newCategoryNode.querySelector('textarea'));

    this.loadOptions(() => {
      this.resetOptions();
      this.loadCategories();
      this.initClickEvent();
      this.initInputEvents();
      this.askForRating();
    });
  }

  loadOptions(successCallback) {
    chrome.storage.sync.get((options) => {
      Object.keys(options).forEach((optionName) => {
        this.options[optionName] = options[optionName];
      });
      successCallback();
    });
  }

  resetOptions() {
    document.querySelector('.use-google-autocomplete').checked = this.options.useGoogleAutocomplete;

    this.getCategoryNodes().forEach((categoryNode) => {
      categoryNode.remove();
    });
  }

  loadCategories() {
    this.options.categories.sort((category1, category2) =>
      category1.name.localeCompare(category2.name)
    );

    this.options.categories.forEach((category) => {
      let categoryNode = this.createCategoryNode();
      this.fillIn(categoryNode, category);

      this.categoriesNode.insertBefore(categoryNode, this.newCategoryNode);
    });
  }

  createCategoryNode() {
    let categoryNode = this.categoryTemplate.cloneNode(true).querySelector('.category');

    this.addCategoryListeners(categoryNode);

    return categoryNode;
  }

  addCategoryListeners(categoryNode) {
    categoryNode.addEventListener('mouseenter', (e) => {
      categoryNode.classList.add('hover');
    });

    categoryNode.addEventListener('mouseleave', (e) => {
      categoryNode.classList.remove('hover');
    });

    if (categoryNode === this.newCategoryNode) return;

    categoryNode.querySelector('.delete').addEventListener('click', (e) => {
      e.stopPropagation();

      categoryNode.remove();
      this.saveCategories();
    });

    categoryNode.querySelector('.default label').addEventListener('click', (e) => {
      e.stopPropagation();
      if (categoryNode.classList.contains('editing')) return;

      if (this.editedCategoryNode) this.unfocusCategory();

      if (this.justSavedCategory) {
        e.preventDefault();
        this.justSavedCategory = false;
      }
      else {
        this.uncheckCategoryNodes(categoryNode);
        this.saveCategories();
      }

      if (this.selectedCategoryNode) {
        this.selectedCategoryNode.classList.remove('selected');
        this.selectedCategoryNode = null;
      }
    });
  }

  fillIn(categoryNode, category) {
    categoryNode.querySelector('.name').textContent = category.name;
    categoryNode.querySelector('.default input').checked = category.defaultCategory;
    categoryNode.querySelector('.keywords').textContent = category.keywords;
    categoryNode.querySelector('.urls').innerHTML = category.urls.join('<br>');
  }

  initClickEvent() {
    document.addEventListener('click', (e) => {
      let categoryNode = e.target.closest('.category');

      if (categoryNode) {
        let clickedColumn = e.target.closest('.column');

        this.edit(categoryNode, clickedColumn);
      }
      else {
        this.unfocusCategory();
      }

      this.justSavedCategory = false;
    });
  }

  edit(categoryNode, clickedColumn) {
    if (categoryNode === this.editedCategoryNode) return;

    if (this.editedCategoryNode) {
      this.editedCategoryNode.classList.remove('selected');

      this.unfocusCategory();
      if (this.justSavedCategory) return;
    }
    else if (this.selectedCategoryNode) {
      this.selectedCategoryNode.classList.remove('selected');
      this.selectedCategoryNode = null;
    }

    this.categoriesNode.classList.add('has-category-focused');

    categoryNode.classList.add('selected', 'editing');

    if (!categoryNode.classList.contains('editable')) {
      this.makeEditable(categoryNode);
    }

    if (clickedColumn) this.focusInput(clickedColumn);

    this.editedCategoryNode = categoryNode;
  }

  makeEditable(categoryNode) {
    categoryNode.classList.add('editable');

    this.editedCategory = this.getInfo(categoryNode);
    let clone = this.editableCategoryTemplate.cloneNode(true);
    let input;

    input = clone.querySelector('.name input');
    input.value = this.editedCategory.name;
    this.setChild(categoryNode.querySelector('.name'), input);

    input = clone.querySelector('.keywords input');
    input.value = this.editedCategory.keywords;
    this.setChild(categoryNode.querySelector('.keywords'), input);

    input = clone.querySelector('.urls textarea');
    input.value = this.editedCategory.urls.join('\n');
    this.setChild(categoryNode.querySelector('.urls'), input);
    autosize(input);

    this.addInputsListener(categoryNode);
  }

  getInfo(categoryNode) {
    return {
      name: categoryNode.querySelector('.name').textContent,
      defaultCategory: categoryNode.querySelector('.default input').checked,
      keywords: categoryNode.querySelector('.keywords').textContent.split(','),
      urls: this.toArray(categoryNode.querySelector('.urls').childNodes)
      .reduce((acc, node) => {
        if (node.nodeValue) acc.push(node.nodeValue);

        return acc;
      }, [])
    };
  }

  toArray(nodeList) {
    return Array.prototype.slice.call(nodeList);
  }

  setChild(parent, child) {
    parent.innerHTML = null;
    parent.appendChild(child);
  }

  addInputsListener(categoryNode) {
    let ENTER_KEY_CODE = 13;
    this.toArray(categoryNode.querySelectorAll('input[type="text"]')).forEach((input) => {
      input.addEventListener('keydown', (e) => {
        if (e.keyCode === ENTER_KEY_CODE) {

          if (this.isValid(categoryNode)) {
            this.unfocusCategory();
            input.blur();
          }
        }
      });
    });

    this.toArray(categoryNode.querySelectorAll('input, textarea')).forEach((input) => {
      input.addEventListener('input', (e) => {
        input.classList.toggle('invalid', !input.value.trim());
      });
    });
  }

  focusInput(clickedColumn) {
    let input = clickedColumn.querySelector('input, textarea');
    if (!input) return;

    input.focus();

    if (input.tagName === 'TEXTAREA') {
      let endIndex = input.value.length;
      input.setSelectionRange(endIndex, endIndex);
    }
  }

  unfocusCategory() {
    this.categoriesNode.classList.remove('has-category-focused');

    if (this.editedCategoryNode) {
      if (this.isValid(this.editedCategoryNode)) {
        this.saveAndMove(this.editedCategoryNode);
      }
      else {
        this.resetCategoryNode(this.editedCategoryNode);
      }

      if (this.editedCategoryNode !== this.newCategoryNode) {
        this.editedCategoryNode.classList.remove('editable');
      }
      this.editedCategoryNode.classList.remove('editing');
      this.selectedCategoryNode = this.editedCategoryNode;
      this.editedCategoryNode = null;
      this.editedCategory = null;
    }
  }

  isValid(categoryNode) {
    return !categoryNode.querySelector(':invalid, .invalid');
  }

  saveAndMove(categoryNode) {
    let category = this.getEditedInfo(categoryNode);

    if (this.areEqual(category, this.editedCategory)) {
      this.resetCategoryNode(categoryNode);
      return;
    }

    categoryNode.classList.remove('selected');

    if (categoryNode === this.newCategoryNode) {
      this.resetCategoryNode(this.newCategoryNode);

      categoryNode = this.createCategoryNode(category);
    }
    this.fillIn(categoryNode, category);

    if (category.defaultCategory) {
      this.uncheckCategoryNodes(categoryNode);
    }

    if (!this.editedCategory || category.name !== this.editedCategory.name) {
      let referenceNode = this.getCategoryNodes().find((currentNode) => {
        if (currentNode.classList.contains('editing')) return false;

        let currentName = this.getInfo(currentNode).name;
        return category.name.localeCompare(currentName) < 0;
      });

      this.categoriesNode.insertBefore(categoryNode, referenceNode || this.newCategoryNode);

      this.getCategoryNodes().forEach((node) => {
        node.classList.remove('hover');
      });
      this.newCategoryNode.classList.remove('hover');
    }

    this.saveCategories();
    this.justSavedCategory = true;
  }

  getEditedInfo(node) {
    return {
      name: node.querySelector('.name input').value.trim(),
      defaultCategory: node.querySelector('.default input').checked,
      keywords: node.querySelector('.keywords input').value.trim().split(','),
      urls: node.querySelector('.urls textarea')
      .value
      .split('\n')
      .reduce((acc, url) => {
        url = url.trim();
        if (url) acc.push(url);

        return acc;
      }, [])
    };
  }

  areEqual(object1, object2) {
    return JSON.stringify(object1) === JSON.stringify(object2);
  }

  resetCategoryNode(categoryNode) {
    if (categoryNode === this.newCategoryNode) {
      this.newCategoryNode.querySelector('.name input').value = null;
      this.newCategoryNode.querySelector('.default input').checked = false;
      this.newCategoryNode.querySelector('.keywords input').value = null;
      this.newCategoryNode.querySelector('.urls textarea').value = null;
    }
    else {
      this.fillIn(categoryNode, this.editedCategory);
    }
  }

  uncheckCategoryNodes(checkedCategoryNode) {
    this.getCategoryNodes().forEach((categoryNode) => {
      if (categoryNode === checkedCategoryNode) return;

      categoryNode.querySelector('.default input').checked = false;
    });
  }

  getCategoryNodes() {
    let nodeList = this.categoriesNode.querySelectorAll('.category:not(.new)');

    return this.toArray(nodeList);
  }

  saveCategories() {
    let categories = this.getCategoryNodes().map((categoryNode) =>
      this.getInfo(categoryNode)
    );

    chrome.storage.sync.set({ categories });
  }

  initInputEvents() {
    document.querySelector('.use-google-autocomplete').addEventListener('click', (e) => {
      chrome.storage.sync.set({ useGoogleAutocomplete: e.target.checked });
    });

    let resetToDefaultsNode = document.querySelector('.reset-to-defaults');
    let resetButton = resetToDefaultsNode.querySelector('.reset');
    let confirmNode = resetToDefaultsNode.querySelector('.confirm');

    resetButton.addEventListener('click', () => {
      resetButton.classList.add('hidden');
      confirmNode.classList.remove('hidden');
    });
    confirmNode.querySelector('.cancel').addEventListener('click', () => {
      confirmNode.classList.add('hidden');
      resetButton.classList.remove('hidden');
    });
    confirmNode.querySelector('.yes').addEventListener('click', () => {
      confirmNode.classList.add('hidden');
      resetButton.classList.remove('hidden');

      fetch('/assets/default_options.json')
        .then((response) => response.json())
        .then((defaultOptions) => {
          chrome.storage.sync.set(defaultOptions);

          window.location.reload();
        });
    });

    this.ratingPromptNode.querySelector('a').addEventListener('click', (e) => {
      this.ratingPromptNode.classList.add('hidden');
      chrome.storage.sync.set({ hideRatingPrompt: true });
    });

    document.querySelector('#done').addEventListener('click', (e) => {
      window.close();
    });
  }

  askForRating() {
    if (this.options.searchCount >= 5 && !this.options.hideRatingPrompt) {
      this.ratingPromptNode.classList.remove('hidden');
    }
  }

  debug(text) {
    document.body.appendChild(document.createElement('br'));

    document.body.appendChild(document.createTextNode(`>>> ${text}`));
  }
}

document.addEventListener('DOMContentLoaded', () => {
  new OptionsPage();
});
