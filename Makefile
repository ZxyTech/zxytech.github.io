.PHONY: module-tidy help

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {sub("\\\\n",sprintf("\n%22c"," "), $$2);printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

serve: npm-ci module-vendor ## Boot the development server.
	hugo server --buildFuture --environment development

serve-prod: npm-ci module-vendor ## Boot the production server.
	hugo server --environment production

build: npm-ci module-vendor ## Build site with non-production settings and put deliverables in ./public
	hugo --cleanDestinationDir --minify --environment development

build-preview: npm-ci module-vendor ## Build site with drafts and future posts enabled
	hugo --cleanDestinationDir --buildDrafts --buildFuture --environment preview

build-prod: npm-ci module-vendor ## Build site with production settings and put deliverables in ./public
	hugo --cleanDestinationDir --minify --environment production

module-vendor: module-tidy
	@hugo mod vendor

module-tidy:
	@hugo mod tidy

npm-ci:
	@npm ci