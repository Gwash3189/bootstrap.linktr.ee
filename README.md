# Welcome aboard

Hello and welcome! This repo is desiged to help you get up to speed with all of the required tools/software as well as any operating system dependencies required to work on Linktree services.

---

## Getting Started

In order to clone this repository there are some system dependencies you will need to proceed.

### Install Command Line Tools

```sh
xcode-select --install
```

### Ensure `git` is installed

```sh
if [ -x "$(command -v git)" ]; then
  echo '✅' >&2
fi
```

## Setting Up

Run

```sh
./get-started.sh && ansible-playbook playbook.yml
```

On your first run of the Ansible playbook, you may be notified to adjust your Security & Privacy settings to allow for applications from developers such as Oracle (Virtualbox). Once you have allowed these applications, re-run the playbook with `ansible-playbook playbook.yml`.
