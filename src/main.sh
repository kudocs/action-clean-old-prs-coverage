main(){
  export GITHUB_TOKEN="$1"

  GITHUB_API_HEADER="Accept: application/vnd.github.v3+json"
  GITHUB_API_URI="https://api.github.com"

  repos=($(ls -d -- */))

  for repo in "${repos[@]}"; do
    repository="${repo%?}"

    echo "Cleaning $repository old files"

    open_prs=($(curl -sSL -H "$GITHUB_API_HEADER" -H "Authorization: Bearer $GITHUB_TOKEN" "$GITHUB_API_URI/repos/kudocs/$repository/pulls"| jq '.[].number'))

    array=("${open_prs[@]/#/ -not -name }")
    command=$(printf '%s' "${array[@]}")

    find ./$repository -mindepth 1 -maxdepth 1 -type d -not -name dev -not -name master -not -name live ${command} -exec rm -rf '{}' \;
  done

  modifiedFiles=($(git status | grep 'modified:' | wc -l))

  if [ "$modifiedFiles" -gt 0 ]; then
    git add . ;
    git -c user.name="GitHub Actions" -c user.email="actions@github.com" \
            commit -m "Delete old coverage files" ;
    git push;
  else
    echo "Nothing changed"
  fi
}
