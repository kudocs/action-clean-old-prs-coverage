# action-clean-old-prs-coverage

<p align="center">
  Delete old coverage files from coverage repo. This action deletes the folders that are no longer needed
</p>

## Args

- GITHUB_TOKEN (required)

## 🚀 Usage

Create a file inside the `.github/workflows` directory and paste:

```yml

name: Delete old coverage files

on:
  schedule:
    - cron:  '0 0 * * *'
jobs:
  delete_files:
    runs-on: ubuntu-latest
    name: Delete old coverage files
    steps:
      - uses: actions/checkout@master
      - uses: kudocs/action-clean-old-prs-coverage@master
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

```

