if [ $OS == "linux" ]; then
	CFLAGS=--target=$TARGET make -f Makefile.dist lib/libraw_r.a
elif [ $OS == "macos" ]; then
	CFLAGS=--target=$TARGET make -f Makefile.dist lib/libraw_r.a
elif [ $OS == "android" ]; then
	source ~/android-ndk-envvars
	export CFLAGS="$CFLAGS --target=$TARGET"
	make -f Makefile.dist lib/libraw_r.a
elif [ $OS == "ios" ]; then
	if [[ $TARGET == *"-simulator" ]]; then
		make -f Makefile.iphoneSimulator lib/libraw_r.a
	else
		make -f Makefile.iphone lib/libraw_r.a
	fi
elif [ $OS == "windows" ]; then
	MSBuild.exe buildfiles/libraw.vcxproj /property:Configuration=Release /property:Platform=$WINDOWS_PLATFORM | ( iconv -f utf-8 -t utf-8 -c || true )
else
	echo Unknown OS: $OS
	exit 1
fi
