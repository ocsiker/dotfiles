class InstantMultiSearch {

  constructor() {
    this.options = {};

    this.loadOptions();
    this.addSearchEvents();
  }

  loadOptions() {
    chrome.runtime.onInstalled.addListener(() => {
      chrome.storage.sync.get('categories', (result) => {
        if (result.categories) return;

        fetch('/assets/default_options.json')
          .then((response) => response.json())
          .then((defaultOptions) => {
            chrome.storage.sync.set(defaultOptions);
          });
      });
    });

    chrome.storage.sync.get((options) => {
      Object.keys(options).forEach((optionName) => {
        this.options[optionName] = options[optionName];
      });
    });

    chrome.storage.onChanged.addListener((changes) => {
      Object.keys(changes).forEach((optionName) => {
        this.options[optionName] = changes[optionName].newValue;
      });
    });
  }

  addSearchEvents() {
    chrome.omnibox.onInputChanged.addListener((searchText, suggestCallback) => {
      this.fillInSuggestions(searchText, suggestCallback);
    });

    chrome.omnibox.onInputEntered.addListener((searchText, tabDisposition) => {
      chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {

        let search = this.parseSearch(searchText);
        if (!search.category || search.text.length === 0) return;

        let currentTab = tabs[0];
        this.multiTabSearch(search, currentTab);
        this.arrangeTabs(tabDisposition, currentTab);
        this.incrementSearchCount();
      });
    });
  }

  fillInSuggestions(searchText, suggestCallback) {
    let search = this.parseSearch(searchText);

    let description = search.text || searchText || 'Instant Multi Search';
    chrome.omnibox.setDefaultSuggestion({ description });

    if (search.text.length === 0 || !this.options.useGoogleAutocomplete) return;

    fetch(`http://suggestqueries.google.com/complete/search?output=firefox&q=${search.text}`)
      .then((response) => response.json())
      .then((response) => {
        let suggestions = response[1].map((suggestion) => {
          let content = suggestion;
          if (search.categoryKeyword) {
            content = `${search.categoryKeyword} ${suggestion}`;
          }

          return { content, description: suggestion };
        });

        suggestCallback(suggestions);
      });
  }

  parseSearch(searchText) {
    let category;

    let matches = searchText.match(/([^ ]+) (.*)/);
    let categoryKeyword = matches ? matches[1] : null;

    if (categoryKeyword) {
      category = this.options.categories.find((category) =>
        category.keywords.includes(categoryKeyword)
      );
    }

    if (category) {
      searchText = matches[2];
    }
    else {
      categoryKeyword = '';

      category = this.options.categories.find((category) =>
        category.defaultCategory
      );
    }

    return {
      category,
      categoryKeyword,
      text: searchText.trim()
    };
  }

  multiTabSearch(search, currentTab) {
    search.category.urls.forEach((url, i) => {
      url = url
        .replace(/\[Feeling Lucky\] ?/, 'https://duckduckgo.com/?q=!ducky+')
        .replace(/\[Google Feeling Lucky\] ?/, 'http://www.google.com/search?btnI&q=')
        .replace(/%s/, search.text);

      chrome.tabs.create({ url, index: currentTab.index + 1 + i });
    });
  }

  arrangeTabs(tabDisposition, currentTab) {
    switch (tabDisposition) {
      case 'currentTab':
        chrome.tabs.update(currentTab.id, { active: true });
        chrome.tabs.remove(currentTab.id);
        break;

      case 'newBackgroundTab':
        chrome.tabs.update(currentTab.id, { active: true });
        break;

      case 'newForegroundTab':
        chrome.tabs.query({ index: currentTab.index + 1, currentWindow: true }, (tabs) => {
          let firstTab = tabs[0];
          chrome.tabs.update(firstTab.id, { active: true });
        });
    }
  }

  incrementSearchCount() {
    let currentCount = this.options.searchCount || 0;
    if (currentCount >= 5) return;

    chrome.storage.sync.set({ searchCount: currentCount + 1 });
  }
}

new InstantMultiSearch();
