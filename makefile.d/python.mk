# Install python runtime and applications using uv

# Install uv, but don't run the update more than once per day
uv-update := /tmp/.uv-update-target
uv := ~/.local/bin/uv
uv: $(uv) $(uv-update) ; @true
$(uv):
	curl -LsSf https://astral.sh/uv/install.sh | sh
$(uv-update): $(call daily,uv-update)
	uv self update
	touch $(@)

xonsh := ~/.local/bin/xonsh
xonsh: ${xonsh}; @true
${xonsh}: uv
	uv tool install xonsh[full] \
	  --python 3.12

# This is the community distribution
ansible-community := ~/.local/bin/ansible-community
ansible-community: ${ansible-community} ; @true
${ansible-community}: uv
	uv tool install ansible

# This is the Red Hat distribution
ansible := ~/.local/bin/ansible
ansible: ${ansible} ; @true
${ansible}: uv
	uv tool install ansible-core
