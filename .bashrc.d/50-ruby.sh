# Initialize ruby environment
for f in ~/.rbenv/bin/rbenv; do
  if [[ -x $f ]]; then
    echo "Initializing rbenv"
    eval "$($f init - --no-rehash bash)"
  else
    echo "local rbenv not available"
  fi
done
