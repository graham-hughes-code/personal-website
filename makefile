build: clean
	cd blog && hugo -b --minify && cd .. && mv blog/public site/blog
clean:
	rm -rf ./site/blog
cloudflare-build: clean
	cd blog && if [ "$CF_PAGES_BRANCH" = "main" ]; then hugo --minify; else hugo -b "${CF_PAGES_URL}/blog/" --minify; fi && cd .. && mv blog/public site/blog
