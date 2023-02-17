/+ dub.sdl:
	name "test"
	dependency "littlecms-d" path="."
+/
module test;

import lcms2;

void main()
{
	auto ctx = cmsCreateContext(null, null);
	assert(ctx !is null);
	cmsDeleteContext(ctx);
}
