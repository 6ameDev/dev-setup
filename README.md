# Barebones Dev Setup

Desgined and maintained purely based on personal preferences of the author.

## Homebrew essentials

#### Formulae
```
brew install \
	git \
	tig \
	tree \
	htop \
	watch
```

#### Casks
```
brew install --casks \
	brave-browser \
	flycut \
	iterm2 \
	rectangle \
	sublime-text \
	vscodium \
        lulu \
        docker
```

## ZSH

#### Dependencies
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
- [pure](https://github.com/sindresorhus/pure#homebrew)
- [fzf](https://github.com/junegunn/fzf#using-homebrew)

#### Config
Place the [.zshrc](.zshrc) file in your home directory.

## Brave Browser

#### Extensions
- [Bitwarden](https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb)
- [Auto Tab Discard](https://chrome.google.com/webstore/detail/auto-tab-discard/jhnleheckmknfcgijgkadoemagpecfol)
- [SponsorBlock for Youtube](https://chrome.google.com/webstore/detail/sponsorblock-for-youtube/mnjggcdmjocbbbhaepdhchncahnbgone)

#### Setup search triggers
- Visit this URL in browser: `brave://settings/searchEngines`
- Add to Site Search   

| Search Engine  | Shortcut | URL |
| --- | --- | --- |
| Google | goo | `https://www.google.com/search?q=%s` |
| Youtube | you | `https://www.youtube.com/results?search_query=%s` |
| Google Drive | dri | `https://drive.google.com/drive/search?q=%s` |
| Amazon | ama | `https://www.amazon.in/s?k=%s` |
| Flipkart | fli | `https://www.flipkart.com/search?q=%s` |
| RottenTomatoes | rot | `https://www.rottentomatoes.com/search?search=%s` |
