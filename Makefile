# IOS SETUP
SDK = /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator14.0.sdk
ARCH_TARGET = x86_64-apple-ios14.0-simulator

# IOS APP SETUP
APP_PATH = IterisApp
APP_NAME = IterisApp
APP_BUNDLE = ${APP_PATH}/${APP_NAME}.app

# DYNAMIC LIBRARY
DYNAMIC_LIB_PATH = IterisDynamicLibrary
DYNAMIC_MODULE_NAME = DynamicModule
DYNAMIC_LIB_NAME = DynamicModule.dylib

# STATIC LIBRARY
STATIC_LIB_PATH = IterisStaticLibrary
STATIC_MODULE_NAME = StaticModule
STATIC_LIB_NAME = StaticModule.a

build-app-without-dependencies:
	# creating structure
	rm -Rf $(APP_BUNDLE)
	mkdir $(APP_BUNDLE)
	cp $(APP_PATH)/Info.plist $(APP_BUNDLE)/Info.plist

	# compiling
	swiftc $(APP_PATH)/*.swift \
	-target $(ARCH_TARGET) -sdk $(SDK) \
	-o ${APP_BUNDLE}/${APP_NAME} 

build-dynamic-library:
	# compiling the dynamic library
	swiftc -working-directory $(DYNAMIC_LIB_PATH) \
	-emit-library -emit-module \
	-target $(ARCH_TARGET) -sdk $(SDK) \
	-module-name ${DYNAMIC_MODULE_NAME} \
	-o ${DYNAMIC_LIB_NAME} \
	DynamicLibrary.swift

build-static-library:
	# compiling the static library
	swiftc -working-directory $(STATIC_LIB_PATH) \
	-emit-library -emit-module -static \
	-target $(ARCH_TARGET) -sdk $(SDK) \
	-module-name ${STATIC_MODULE_NAME} \
	-o ${STATIC_LIB_NAME} \
	StaticLibrary.swift

build-module-a:
	swiftc -working-directory IterisAppModuleA -emit-library -emit-module \
	-I ../${DYNAMIC_LIB_PATH} -I ../${STATIC_LIB_PATH} \
	-Xlinker ./${DYNAMIC_LIB_PATH}/${DYNAMIC_LIB_NAME} \
	-Xlinker ./${STATIC_LIB_PATH}/${STATIC_LIB_NAME} \
	-target $(ARCH_TARGET) -sdk $(SDK) \
	-module-name ModuleA \
	-o ModuleA.dylib \
	ModuleAViewController.swift

build-module-b:
	swiftc -working-directory IterisAppModuleB -emit-library -emit-module \
	-I ../${DYNAMIC_LIB_PATH} -I ../${STATIC_LIB_PATH} \
	-Xlinker ./${DYNAMIC_LIB_PATH}/${DYNAMIC_LIB_NAME} \
	-Xlinker ./${STATIC_LIB_PATH}/${STATIC_LIB_NAME} \
	-target $(ARCH_TARGET) -sdk $(SDK) \
	-module-name ModuleB \
	-o ModuleB.dylib \
	ModuleBViewController.swift

build-modules:
	make build-dynamic-library
	make build-static-library
	make build-module-a
	make build-module-b

build-app-with-dependencies:
	# compiling dependencies
	make build-modules

	# creating structure
	rm -Rf $(APP_BUNDLE)
	mkdir $(APP_BUNDLE)
	cp $(APP_PATH)/Info.plist $(APP_BUNDLE)/Info.plist

	# compiling
	swiftc $(APP_PATH)/*.swift \
	-I IterisAppModuleA -I IterisAppModuleB \
	-I ${DYNAMIC_LIB_PATH} -I ${STATIC_LIB_PATH} \
	-Xlinker ${DYNAMIC_LIB_PATH}/${DYNAMIC_LIB_NAME} \
	-Xlinker ${STATIC_LIB_PATH}/${STATIC_LIB_NAME} \
	-Xlinker IterisAppModuleA/ModuleA.dylib \
	-Xlinker IterisAppModuleB/ModuleB.dylib \
	-target $(ARCH_TARGET) -sdk $(SDK) \
	-o ${APP_BUNDLE}/${APP_NAME}