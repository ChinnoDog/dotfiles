# Prevent targets from executing too often
# Call with $(call daily,<target>)

/tmp/.daily.%.timestamp: FORCE
	@if [ ! -f $@ ] || [ "$$(find $@ -mtime +0)" ]; then \
		echo "Refreshing daily trigger for $*..."; \
		touch $@; \
	else \
		echo "Daily trigger for $* is still fresh"; \
	fi

define daily
/tmp/.daily.$(1).timestamp
endef
