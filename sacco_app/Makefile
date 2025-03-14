.PHONY: build-apk build-appbundle

build-apk:
	@echo "--------Clean---------"
	flutter clean
	@echo "--------Get packages---------"
	flutter pub get
	@echo "--------Building the apk---------"
	flutter build apk --release

build-appbundle:
	@echo "--------Clean---------"
	flutter clean
	@echo "--------Get packages---------"
	flutter pub get
	@echo "--------Building the appbundle---------"
	flutter build appbundle