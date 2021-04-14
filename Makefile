.PHONY: test
test:
	@$(MAKE) -C vagrant setup.site

clean:
	@$(MAKE) -C vagrant clean
