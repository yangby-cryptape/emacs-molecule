# Abir
[![License]](#license)

A Package for [Molecule] in [Emacs].

[License]: https://img.shields.io/github/license/yangby-cryptape/emacs-molecule.svg

## Features

- Syntax Highlighting
- Indentation (simple)

## Installation

### Manual

- Download [the source code](https://github.com/yangby-cryptape/emacs-molecule/archive/master.zip).
- Extract the downloaded package into the directory `${HOME}/.emacs.d/` and rename it to `molecule`.
- Add the following code into your emacs configuration:

```elisp
(add-to-list 'load-path "~/.emacs.d/molecule")
(require 'molecule-mode)
(add-to-list 'auto-mode-alist '("\\.mol\\'" . molecule-mode))
```

## License

Licensed under [GNU Affero General Public License v3.0].

[GNU Affero General Public License v3.0]: LICENSE

[Molecule]: https://github.com/nervosnetwork/molecule
[Emacs]: https://www.gnu.org/software/emacs/
