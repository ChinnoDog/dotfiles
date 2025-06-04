# Alias for jira cli
alias acli='docker run -ti --rm --name acli \
  -e chinnodog="jira -s https://chinnodog.atlassian.net -u chinnodog@gmail.com" \
  -e chinnodog_confluence="confluence -s https://chinnodog.atlassian.net -u chinnodog@gmail.com" \
  bobswiftapps/acli:latest /bin/bash'
