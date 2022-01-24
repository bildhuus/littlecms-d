//---------------------------------------------------------------------------------

import core.stdc.config;
import core.stdc.stddef;
import core.stdc.stdio;
import core.stdc.time;

extern (C) nothrow:

//
//  Little Color Management System
//  Copyright (c) 1998-2022 Marti Maria Saguer
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software
// is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//---------------------------------------------------------------------------------
//
// Version 2.13rc1
//

// ********** Configuration toggles ****************************************

// Uncomment this one if you are using big endian machines
// #define CMS_USE_BIG_ENDIAN   1

// Uncomment this one if your compiler/machine does NOT support the
// "long long" type.
// #define CMS_DONT_USE_INT64        1

// Uncomment this if your compiler doesn't work with fast floor function
// #define CMS_DONT_USE_FAST_FLOOR 1

// Uncomment this line if you want lcms to use the black point tag in profile,
// if commented, lcms will compute the black point by its own.
// It is safer to leave it commented out
// #define CMS_USE_PROFILE_BLACK_POINT_TAG    1

// Uncomment this line if you are compiling as C++ and want a C++ API
// #define CMS_USE_CPP_API

// Uncomment this line if you need strict CGATS syntax. Makes CGATS files to
// require "KEYWORD" on undefined identifiers, keep it commented out unless needed
// #define CMS_STRICT_CGATS  1

// Uncomment to get rid of the tables for "half" float support
// #define CMS_NO_HALF_SUPPORT 1

// Uncomment to get rid of pthreads/windows dependency
// #define CMS_NO_PTHREADS  1

// Uncomment this for special windows mutex initialization (see lcms2_internal.h)
// #define CMS_RELY_ON_WINDOWS_STATIC_MUTEX_INIT

// Uncomment this to remove the "register" storage class
// #define CMS_NO_REGISTER_KEYWORD 1

// ********** End of configuration toggles ******************************

// Needed for streams

// Needed for portability (C99 per 7.1.2)

// Version/release

// I will give the chance of redefining basic types for compilers that are not fully C99 compliant

// Base types
alias cmsUInt8Number = ubyte; // That is guaranteed by the C99 spec
alias cmsInt8Number = byte; // That is guaranteed by the C99 spec

// IEEE float storage numbers
alias cmsFloat32Number = float;
alias cmsFloat64Number = double;

// 16-bit base types

alias cmsUInt16Number = ushort;

alias cmsInt16Number = short;

// 32-bit base type

alias cmsUInt32Number = uint;

alias cmsInt32Number = int;

// 64-bit base types

alias cmsUInt64Number = c_ulong;

alias cmsInt64Number = c_long;

// Handle "register" keyword

// In the case 64 bit numbers are not supported by the compiler

// Derivative types
alias cmsSignature = uint;
alias cmsU8Fixed8Number = ushort;
alias cmsS15Fixed16Number = int;
alias cmsU16Fixed16Number = uint;

// Boolean type, which will be using the native integer
alias cmsBool = int;

// Try to detect windows

// Try to detect big endian platforms. This list can be endless, so primarily rely on the configure script
// on Unix-like systems, and allow it to be set on the compiler command line using
// -DCMS_USE_BIG_ENDIAN or something similar
// set at compiler command line takes overall precedence

// CMS_USE_BIG_ENDIAN

// set by configure (or explicitly on compiler command line)

// WORDS_BIGENDIAN
// Fall back to platform/compiler specific tests

// WORDS_BIGENDIAN

// CMS_USE_BIG_ENDIAN

// Calling convention -- this is hardly platform and compiler dependent

// not Windows

// CMS_IS_WINDOWS_

// Some common definitions

// D50 XYZ normalized to Y=1.0

// V4 perceptual black

// Definitions in ICC spec
// 'acsp'
// 'lcms'

// Base ICC type definitions
enum cmsTagTypeSignature
{
    cmsSigChromaticityType = 0x6368726D, // 'chrm'
    cmsSigColorantOrderType = 0x636C726F, // 'clro'
    cmsSigColorantTableType = 0x636C7274, // 'clrt'
    cmsSigCrdInfoType = 0x63726469, // 'crdi'
    cmsSigCurveType = 0x63757276, // 'curv'
    cmsSigDataType = 0x64617461, // 'data'
    cmsSigDictType = 0x64696374, // 'dict'
    cmsSigDateTimeType = 0x6474696D, // 'dtim'
    cmsSigDeviceSettingsType = 0x64657673, // 'devs'
    cmsSigLut16Type = 0x6d667432, // 'mft2'
    cmsSigLut8Type = 0x6d667431, // 'mft1'
    cmsSigLutAtoBType = 0x6d414220, // 'mAB '
    cmsSigLutBtoAType = 0x6d424120, // 'mBA '
    cmsSigMeasurementType = 0x6D656173, // 'meas'
    cmsSigMultiLocalizedUnicodeType = 0x6D6C7563, // 'mluc'
    cmsSigMultiProcessElementType = 0x6D706574, // 'mpet'
    cmsSigNamedColorType = 0x6E636f6C, // 'ncol' -- DEPRECATED!
    cmsSigNamedColor2Type = 0x6E636C32, // 'ncl2'
    cmsSigParametricCurveType = 0x70617261, // 'para'
    cmsSigProfileSequenceDescType = 0x70736571, // 'pseq'
    cmsSigProfileSequenceIdType = 0x70736964, // 'psid'
    cmsSigResponseCurveSet16Type = 0x72637332, // 'rcs2'
    cmsSigS15Fixed16ArrayType = 0x73663332, // 'sf32'
    cmsSigScreeningType = 0x7363726E, // 'scrn'
    cmsSigSignatureType = 0x73696720, // 'sig '
    cmsSigTextType = 0x74657874, // 'text'
    cmsSigTextDescriptionType = 0x64657363, // 'desc'
    cmsSigU16Fixed16ArrayType = 0x75663332, // 'uf32'
    cmsSigUcrBgType = 0x62666420, // 'bfd '
    cmsSigUInt16ArrayType = 0x75693136, // 'ui16'
    cmsSigUInt32ArrayType = 0x75693332, // 'ui32'
    cmsSigUInt64ArrayType = 0x75693634, // 'ui64'
    cmsSigUInt8ArrayType = 0x75693038, // 'ui08'
    cmsSigVcgtType = 0x76636774, // 'vcgt'
    cmsSigViewingConditionsType = 0x76696577, // 'view'
    cmsSigXYZType = 0x58595A20 // 'XYZ '
}

// Base ICC tag definitions
enum cmsTagSignature
{
    cmsSigAToB0Tag = 0x41324230, // 'A2B0'
    cmsSigAToB1Tag = 0x41324231, // 'A2B1'
    cmsSigAToB2Tag = 0x41324232, // 'A2B2'
    cmsSigBlueColorantTag = 0x6258595A, // 'bXYZ'
    cmsSigBlueMatrixColumnTag = 0x6258595A, // 'bXYZ'
    cmsSigBlueTRCTag = 0x62545243, // 'bTRC'
    cmsSigBToA0Tag = 0x42324130, // 'B2A0'
    cmsSigBToA1Tag = 0x42324131, // 'B2A1'
    cmsSigBToA2Tag = 0x42324132, // 'B2A2'
    cmsSigCalibrationDateTimeTag = 0x63616C74, // 'calt'
    cmsSigCharTargetTag = 0x74617267, // 'targ'
    cmsSigChromaticAdaptationTag = 0x63686164, // 'chad'
    cmsSigChromaticityTag = 0x6368726D, // 'chrm'
    cmsSigColorantOrderTag = 0x636C726F, // 'clro'
    cmsSigColorantTableTag = 0x636C7274, // 'clrt'
    cmsSigColorantTableOutTag = 0x636C6F74, // 'clot'
    cmsSigColorimetricIntentImageStateTag = 0x63696973, // 'ciis'
    cmsSigCopyrightTag = 0x63707274, // 'cprt'
    cmsSigCrdInfoTag = 0x63726469, // 'crdi'
    cmsSigDataTag = 0x64617461, // 'data'
    cmsSigDateTimeTag = 0x6474696D, // 'dtim'
    cmsSigDeviceMfgDescTag = 0x646D6E64, // 'dmnd'
    cmsSigDeviceModelDescTag = 0x646D6464, // 'dmdd'
    cmsSigDeviceSettingsTag = 0x64657673, // 'devs'
    cmsSigDToB0Tag = 0x44324230, // 'D2B0'
    cmsSigDToB1Tag = 0x44324231, // 'D2B1'
    cmsSigDToB2Tag = 0x44324232, // 'D2B2'
    cmsSigDToB3Tag = 0x44324233, // 'D2B3'
    cmsSigBToD0Tag = 0x42324430, // 'B2D0'
    cmsSigBToD1Tag = 0x42324431, // 'B2D1'
    cmsSigBToD2Tag = 0x42324432, // 'B2D2'
    cmsSigBToD3Tag = 0x42324433, // 'B2D3'
    cmsSigGamutTag = 0x67616D74, // 'gamt'
    cmsSigGrayTRCTag = 0x6b545243, // 'kTRC'
    cmsSigGreenColorantTag = 0x6758595A, // 'gXYZ'
    cmsSigGreenMatrixColumnTag = 0x6758595A, // 'gXYZ'
    cmsSigGreenTRCTag = 0x67545243, // 'gTRC'
    cmsSigLuminanceTag = 0x6C756d69, // 'lumi'
    cmsSigMeasurementTag = 0x6D656173, // 'meas'
    cmsSigMediaBlackPointTag = 0x626B7074, // 'bkpt'
    cmsSigMediaWhitePointTag = 0x77747074, // 'wtpt'
    cmsSigNamedColorTag = 0x6E636f6C, // 'ncol' // Deprecated by the ICC
    cmsSigNamedColor2Tag = 0x6E636C32, // 'ncl2'
    cmsSigOutputResponseTag = 0x72657370, // 'resp'
    cmsSigPerceptualRenderingIntentGamutTag = 0x72696730, // 'rig0'
    cmsSigPreview0Tag = 0x70726530, // 'pre0'
    cmsSigPreview1Tag = 0x70726531, // 'pre1'
    cmsSigPreview2Tag = 0x70726532, // 'pre2'
    cmsSigProfileDescriptionTag = 0x64657363, // 'desc'
    cmsSigProfileDescriptionMLTag = 0x6473636d, // 'dscm'
    cmsSigProfileSequenceDescTag = 0x70736571, // 'pseq'
    cmsSigProfileSequenceIdTag = 0x70736964, // 'psid'
    cmsSigPs2CRD0Tag = 0x70736430, // 'psd0'
    cmsSigPs2CRD1Tag = 0x70736431, // 'psd1'
    cmsSigPs2CRD2Tag = 0x70736432, // 'psd2'
    cmsSigPs2CRD3Tag = 0x70736433, // 'psd3'
    cmsSigPs2CSATag = 0x70733273, // 'ps2s'
    cmsSigPs2RenderingIntentTag = 0x70733269, // 'ps2i'
    cmsSigRedColorantTag = 0x7258595A, // 'rXYZ'
    cmsSigRedMatrixColumnTag = 0x7258595A, // 'rXYZ'
    cmsSigRedTRCTag = 0x72545243, // 'rTRC'
    cmsSigSaturationRenderingIntentGamutTag = 0x72696732, // 'rig2'
    cmsSigScreeningDescTag = 0x73637264, // 'scrd'
    cmsSigScreeningTag = 0x7363726E, // 'scrn'
    cmsSigTechnologyTag = 0x74656368, // 'tech'
    cmsSigUcrBgTag = 0x62666420, // 'bfd '
    cmsSigViewingCondDescTag = 0x76756564, // 'vued'
    cmsSigViewingConditionsTag = 0x76696577, // 'view'
    cmsSigVcgtTag = 0x76636774, // 'vcgt'
    cmsSigMetaTag = 0x6D657461, // 'meta'
    cmsSigArgyllArtsTag = 0x61727473 // 'arts'
}

// ICC Technology tag
enum cmsTechnologySignature
{
    cmsSigDigitalCamera = 0x6463616D, // 'dcam'
    cmsSigFilmScanner = 0x6673636E, // 'fscn'
    cmsSigReflectiveScanner = 0x7273636E, // 'rscn'
    cmsSigInkJetPrinter = 0x696A6574, // 'ijet'
    cmsSigThermalWaxPrinter = 0x74776178, // 'twax'
    cmsSigElectrophotographicPrinter = 0x6570686F, // 'epho'
    cmsSigElectrostaticPrinter = 0x65737461, // 'esta'
    cmsSigDyeSublimationPrinter = 0x64737562, // 'dsub'
    cmsSigPhotographicPaperPrinter = 0x7270686F, // 'rpho'
    cmsSigFilmWriter = 0x6670726E, // 'fprn'
    cmsSigVideoMonitor = 0x7669646D, // 'vidm'
    cmsSigVideoCamera = 0x76696463, // 'vidc'
    cmsSigProjectionTelevision = 0x706A7476, // 'pjtv'
    cmsSigCRTDisplay = 0x43525420, // 'CRT '
    cmsSigPMDisplay = 0x504D4420, // 'PMD '
    cmsSigAMDisplay = 0x414D4420, // 'AMD '
    cmsSigPhotoCD = 0x4B504344, // 'KPCD'
    cmsSigPhotoImageSetter = 0x696D6773, // 'imgs'
    cmsSigGravure = 0x67726176, // 'grav'
    cmsSigOffsetLithography = 0x6F666673, // 'offs'
    cmsSigSilkscreen = 0x73696C6B, // 'silk'
    cmsSigFlexography = 0x666C6578, // 'flex'
    cmsSigMotionPictureFilmScanner = 0x6D706673, // 'mpfs'
    cmsSigMotionPictureFilmRecorder = 0x6D706672, // 'mpfr'
    cmsSigDigitalMotionPictureCamera = 0x646D7063, // 'dmpc'
    cmsSigDigitalCinemaProjector = 0x64636A70 // 'dcpj'
}

// ICC Color spaces
enum cmsColorSpaceSignature
{
    cmsSigXYZData = 0x58595A20, // 'XYZ '
    cmsSigLabData = 0x4C616220, // 'Lab '
    cmsSigLuvData = 0x4C757620, // 'Luv '
    cmsSigYCbCrData = 0x59436272, // 'YCbr'
    cmsSigYxyData = 0x59787920, // 'Yxy '
    cmsSigRgbData = 0x52474220, // 'RGB '
    cmsSigGrayData = 0x47524159, // 'GRAY'
    cmsSigHsvData = 0x48535620, // 'HSV '
    cmsSigHlsData = 0x484C5320, // 'HLS '
    cmsSigCmykData = 0x434D594B, // 'CMYK'
    cmsSigCmyData = 0x434D5920, // 'CMY '
    cmsSigMCH1Data = 0x4D434831, // 'MCH1'
    cmsSigMCH2Data = 0x4D434832, // 'MCH2'
    cmsSigMCH3Data = 0x4D434833, // 'MCH3'
    cmsSigMCH4Data = 0x4D434834, // 'MCH4'
    cmsSigMCH5Data = 0x4D434835, // 'MCH5'
    cmsSigMCH6Data = 0x4D434836, // 'MCH6'
    cmsSigMCH7Data = 0x4D434837, // 'MCH7'
    cmsSigMCH8Data = 0x4D434838, // 'MCH8'
    cmsSigMCH9Data = 0x4D434839, // 'MCH9'
    cmsSigMCHAData = 0x4D434841, // 'MCHA'
    cmsSigMCHBData = 0x4D434842, // 'MCHB'
    cmsSigMCHCData = 0x4D434843, // 'MCHC'
    cmsSigMCHDData = 0x4D434844, // 'MCHD'
    cmsSigMCHEData = 0x4D434845, // 'MCHE'
    cmsSigMCHFData = 0x4D434846, // 'MCHF'
    cmsSigNamedData = 0x6e6d636c, // 'nmcl'
    cmsSig1colorData = 0x31434C52, // '1CLR'
    cmsSig2colorData = 0x32434C52, // '2CLR'
    cmsSig3colorData = 0x33434C52, // '3CLR'
    cmsSig4colorData = 0x34434C52, // '4CLR'
    cmsSig5colorData = 0x35434C52, // '5CLR'
    cmsSig6colorData = 0x36434C52, // '6CLR'
    cmsSig7colorData = 0x37434C52, // '7CLR'
    cmsSig8colorData = 0x38434C52, // '8CLR'
    cmsSig9colorData = 0x39434C52, // '9CLR'
    cmsSig10colorData = 0x41434C52, // 'ACLR'
    cmsSig11colorData = 0x42434C52, // 'BCLR'
    cmsSig12colorData = 0x43434C52, // 'CCLR'
    cmsSig13colorData = 0x44434C52, // 'DCLR'
    cmsSig14colorData = 0x45434C52, // 'ECLR'
    cmsSig15colorData = 0x46434C52, // 'FCLR'
    cmsSigLuvKData = 0x4C75764B // 'LuvK'
}

// ICC Profile Class
enum cmsProfileClassSignature
{
    cmsSigInputClass = 0x73636E72, // 'scnr'
    cmsSigDisplayClass = 0x6D6E7472, // 'mntr'
    cmsSigOutputClass = 0x70727472, // 'prtr'
    cmsSigLinkClass = 0x6C696E6B, // 'link'
    cmsSigAbstractClass = 0x61627374, // 'abst'
    cmsSigColorSpaceClass = 0x73706163, // 'spac'
    cmsSigNamedColorClass = 0x6e6d636c // 'nmcl'
}

// ICC Platforms
enum cmsPlatformSignature
{
    cmsSigMacintosh = 0x4150504C, // 'APPL'
    cmsSigMicrosoft = 0x4D534654, // 'MSFT'
    cmsSigSolaris = 0x53554E57, // 'SUNW'
    cmsSigSGI = 0x53474920, // 'SGI '
    cmsSigTaligent = 0x54474E54, // 'TGNT'
    cmsSigUnices = 0x2A6E6978 // '*nix'   // From argyll -- Not official
}

// Reference gamut
//'prmg'

// For cmsSigColorimetricIntentImageStateTag
//'scoe'
//'sape'
//'fpce'
//'rhoc'
//'rpoc'

// Multi process elements types
enum cmsStageSignature
{
    cmsSigCurveSetElemType = 0x63767374, //'cvst'
    cmsSigMatrixElemType = 0x6D617466, //'matf'
    cmsSigCLutElemType = 0x636C7574, //'clut'

    cmsSigBAcsElemType = 0x62414353, // 'bACS'
    cmsSigEAcsElemType = 0x65414353, // 'eACS'

    // Custom from here, not in the ICC Spec
    cmsSigXYZ2LabElemType = 0x6C327820, // 'l2x '
    cmsSigLab2XYZElemType = 0x78326C20, // 'x2l '
    cmsSigNamedColorElemType = 0x6E636C20, // 'ncl '
    cmsSigLabV2toV4 = 0x32203420, // '2 4 '
    cmsSigLabV4toV2 = 0x34203220, // '4 2 '

    // Identities
    cmsSigIdentityElemType = 0x69646E20, // 'idn '

    // Float to floatPCS
    cmsSigLab2FloatPCS = 0x64326C20, // 'd2l '
    cmsSigFloatPCS2Lab = 0x6C326420, // 'l2d '
    cmsSigXYZ2FloatPCS = 0x64327820, // 'd2x '
    cmsSigFloatPCS2XYZ = 0x78326420, // 'x2d '  
    cmsSigClipNegativesElemType = 0x636c7020 // 'clp '
}

// Types of CurveElements
enum cmsCurveSegSignature
{
    cmsSigFormulaCurveSeg = 0x70617266, // 'parf'
    cmsSigSampledCurveSeg = 0x73616D66, // 'samf'
    cmsSigSegmentedCurve = 0x63757266 // 'curf'
}

// Used in ResponseCurveType
//'StaA'
//'StaE'
//'StaI'
//'StaT'
//'StaM'
//'DN  '
//'DN P'
//'DNN '
//'DNNP'

// Device attributes, currently defined values correspond to the low 4 bytes
// of the 8 byte attribute quantity

// Common structures in ICC tags
struct cmsICCData
{
    cmsUInt32Number len;
    cmsUInt32Number flag;
    cmsUInt8Number[1] data;
}

// ICC date time
struct cmsDateTimeNumber
{
    cmsUInt16Number year;
    cmsUInt16Number month;
    cmsUInt16Number day;
    cmsUInt16Number hours;
    cmsUInt16Number minutes;
    cmsUInt16Number seconds;
}

// ICC XYZ
struct cmsEncodedXYZNumber
{
    cmsS15Fixed16Number X;
    cmsS15Fixed16Number Y;
    cmsS15Fixed16Number Z;
}

// Profile ID as computed by MD5 algorithm
union cmsProfileID
{
    cmsUInt8Number[16] ID8;
    cmsUInt16Number[8] ID16;
    cmsUInt32Number[4] ID32;
}

// ----------------------------------------------------------------------------------------------
// ICC profile internal base types. Strictly, shouldn't be declared in this header, but maybe
// somebody want to use this info for accessing profile header directly, so here it is.

// Profile header -- it is 32-bit aligned, so no issues are expected on alignment
struct cmsICCHeader
{
    cmsUInt32Number size; // Profile size in bytes
    cmsSignature cmmId; // CMM for this profile
    cmsUInt32Number version_; // Format version number
    cmsProfileClassSignature deviceClass; // Type of profile
    cmsColorSpaceSignature colorSpace; // Color space of data
    cmsColorSpaceSignature pcs; // PCS, XYZ or Lab only
    cmsDateTimeNumber date; // Date profile was created
    cmsSignature magic; // Magic Number to identify an ICC profile
    cmsPlatformSignature platform; // Primary Platform
    cmsUInt32Number flags; // Various bit settings
    cmsSignature manufacturer; // Device manufacturer
    cmsUInt32Number model; // Device model number
    cmsUInt64Number attributes; // Device attributes
    cmsUInt32Number renderingIntent; // Rendering intent
    cmsEncodedXYZNumber illuminant; // Profile illuminant
    cmsSignature creator; // Profile creator
    cmsProfileID profileID; // Profile ID using MD5
    cmsInt8Number[28] reserved; // Reserved for future use
}

// ICC base tag
struct cmsTagBase
{
    cmsTagTypeSignature sig;
    cmsInt8Number[4] reserved;
}

// A tag entry in directory
struct cmsTagEntry
{
    cmsTagSignature sig; // The tag signature
    cmsUInt32Number offset; // Start of tag
    cmsUInt32Number size; // Size in bytes
}

// ----------------------------------------------------------------------------------------------

// Little CMS specific typedefs

alias cmsHANDLE = void*; // Generic handle
alias cmsHPROFILE = void*; // Opaque typedefs to hide internals
alias cmsHTRANSFORM = void*;

// Maximum number of channels in ICC profiles

// Format of pixel is defined by one cmsUInt32Number, using bit fields as follows
//
//                               2                1          0
//                        4 3 2 10987 6 5 4 3 2 1 098 7654 321
//                        M A O TTTTT U Y F P X S EEE CCCC BBB
//
//            M: Premultiplied alpha (only works when extra samples is 1)
//            A: Floating point -- With this flag we can differentiate 16 bits as float and as int
//            O: Optimized -- previous optimization already returns the final 8-bit value
//            T: Pixeltype
//            F: Flavor  0=MinIsBlack(Chocolate) 1=MinIsWhite(Vanilla)
//            P: Planar? 0=Chunky, 1=Planar
//            X: swap 16 bps endianness?
//            S: Do swap? ie, BGR, KYMC
//            E: Extra samples
//            C: Channels (Samples per pixel)
//            B: bytes per sample
//            Y: Swap first - changes ABGR to BGRA and KCMY to CMYK

// These macros unpack format specifiers into integers

// Pixel types
// Don't check colorspace
// 1 & 2 are reserved

// Lu'v'

// Lu'v'K

// Identical to PT_Lab, but using the V2 old encoding

// Some (not all!) representations

// TYPE_RGB_8 is a very common identifier, so don't include ours
// if user has it already defined.

// Colorimetric

// YCbCr

// YUV

// HLS

// HSV

// Named color index. Only 16 bits is allowed (don't check colorspace)

// Float formatters.

// Floating point formatters.
// NOTE THAT 'BYTES' FIELD IS SET TO ZERO ON DLB because 8 bytes overflows the bitfield

// IEEE 754-2008 "half"

// Colorspaces
struct cmsCIEXYZ
{
    cmsFloat64Number X;
    cmsFloat64Number Y;
    cmsFloat64Number Z;
}

struct cmsCIExyY
{
    cmsFloat64Number x;
    cmsFloat64Number y;
    cmsFloat64Number Y;
}

struct cmsCIELab
{
    cmsFloat64Number L;
    cmsFloat64Number a;
    cmsFloat64Number b;
}

struct cmsCIELCh
{
    cmsFloat64Number L;
    cmsFloat64Number C;
    cmsFloat64Number h;
}

struct cmsJCh
{
    cmsFloat64Number J;
    cmsFloat64Number C;
    cmsFloat64Number h;
}

struct cmsCIEXYZTRIPLE
{
    cmsCIEXYZ Red;
    cmsCIEXYZ Green;
    cmsCIEXYZ Blue;
}

struct cmsCIExyYTRIPLE
{
    cmsCIExyY Red;
    cmsCIExyY Green;
    cmsCIExyY Blue;
}

// Illuminant types for structs below

struct cmsICCMeasurementConditions
{
    cmsUInt32Number Observer; // 0 = unknown, 1=CIE 1931, 2=CIE 1964
    cmsCIEXYZ Backing; // Value of backing
    cmsUInt32Number Geometry; // 0=unknown, 1=45/0, 0/45 2=0d, d/0
    cmsFloat64Number Flare; // 0..1.0
    cmsUInt32Number IlluminantType;
}

struct cmsICCViewingConditions
{
    cmsCIEXYZ IlluminantXYZ; // Not the same struct as CAM02,
    cmsCIEXYZ SurroundXYZ; // This is for storing the tag
    cmsUInt32Number IlluminantType; // viewing condition
}

// Get LittleCMS version (for shared objects) -----------------------------------------------------------------------------

int cmsGetEncodedCMMversion ();

// Support of non-standard functions --------------------------------------------------------------------------------------

int cmsstrcasecmp (const(char)* s1, const(char)* s2);
c_long cmsfilelength (FILE* f);

// Context handling --------------------------------------------------------------------------------------------------------

// Each context holds its owns globals and its own plug-ins. There is a global context with the id = 0 for lecacy compatibility
// though using the global context is not recommended. Proper context handling makes lcms more thread-safe.

struct _cmsContext_struct;
alias cmsContext = _cmsContext_struct*;

cmsContext cmsCreateContext (void* Plugin, void* UserData);
void cmsDeleteContext (cmsContext ContextID);
cmsContext cmsDupContext (cmsContext ContextID, void* NewUserData);
void* cmsGetContextUserData (cmsContext ContextID);

// Plug-In registering  --------------------------------------------------------------------------------------------------

cmsBool cmsPlugin (void* Plugin);
cmsBool cmsPluginTHR (cmsContext ContextID, void* Plugin);
void cmsUnregisterPlugins ();
void cmsUnregisterPluginsTHR (cmsContext ContextID);

// Error logging ----------------------------------------------------------------------------------------------------------

// There is no error handling at all. When a function fails, it returns proper value.
// For example, all create functions does return NULL on failure. Other may return FALSE.
// It may be interesting, for the developer, to know why the function is failing.
// for that reason, lcms2 does offer a logging function. This function will get
// an ENGLISH string with some clues on what is going wrong. You can show this
// info to the end user if you wish, or just create some sort of log on disk.
// The logging function should NOT terminate the program, as this obviously can leave
// unfreed resources. It is the programmer's responsibility to check each function
// return code to make sure it didn't fail.

// Error logger is called with the ContextID when a message is raised. This gives the
// chance to know which thread is responsible of the warning and any environment associated
// with it. Non-multithreading applications may safely ignore this parameter.
// Note that under certain special circumstances, ContextID may be NULL.
alias cmsLogErrorHandlerFunction = void function (cmsContext ContextID, cmsUInt32Number ErrorCode, const(char)* Text);

// Allows user to set any specific logger
void cmsSetLogErrorHandler (cmsLogErrorHandlerFunction Fn);
void cmsSetLogErrorHandlerTHR (cmsContext ContextID, cmsLogErrorHandlerFunction Fn);

// Conversions --------------------------------------------------------------------------------------------------------------

// Returns pointers to constant structs
const(cmsCIEXYZ)* cmsD50_XYZ ();
const(cmsCIExyY)* cmsD50_xyY ();

// Colorimetric space conversions
void cmsXYZ2xyY (cmsCIExyY* Dest, const(cmsCIEXYZ)* Source);
void cmsxyY2XYZ (cmsCIEXYZ* Dest, const(cmsCIExyY)* Source);
void cmsXYZ2Lab (const(cmsCIEXYZ)* WhitePoint, cmsCIELab* Lab, const(cmsCIEXYZ)* xyz);
void cmsLab2XYZ (const(cmsCIEXYZ)* WhitePoint, cmsCIEXYZ* xyz, const(cmsCIELab)* Lab);
void cmsLab2LCh (cmsCIELCh* LCh, const(cmsCIELab)* Lab);
void cmsLCh2Lab (cmsCIELab* Lab, const(cmsCIELCh)* LCh);

// Encoding /Decoding on PCS
void cmsLabEncoded2Float (cmsCIELab* Lab, ref const(cmsUInt16Number)[3] wLab);
void cmsLabEncoded2FloatV2 (cmsCIELab* Lab, ref const(cmsUInt16Number)[3] wLab);
void cmsFloat2LabEncoded (ref cmsUInt16Number[3] wLab, const(cmsCIELab)* Lab);
void cmsFloat2LabEncodedV2 (ref cmsUInt16Number[3] wLab, const(cmsCIELab)* Lab);
void cmsXYZEncoded2Float (cmsCIEXYZ* fxyz, ref const(cmsUInt16Number)[3] XYZ);
void cmsFloat2XYZEncoded (ref cmsUInt16Number[3] XYZ, const(cmsCIEXYZ)* fXYZ);

// DeltaE metrics
cmsFloat64Number cmsDeltaE (const(cmsCIELab)* Lab1, const(cmsCIELab)* Lab2);
cmsFloat64Number cmsCIE94DeltaE (const(cmsCIELab)* Lab1, const(cmsCIELab)* Lab2);
cmsFloat64Number cmsBFDdeltaE (const(cmsCIELab)* Lab1, const(cmsCIELab)* Lab2);
cmsFloat64Number cmsCMCdeltaE (const(cmsCIELab)* Lab1, const(cmsCIELab)* Lab2, cmsFloat64Number l, cmsFloat64Number c);
cmsFloat64Number cmsCIE2000DeltaE (const(cmsCIELab)* Lab1, const(cmsCIELab)* Lab2, cmsFloat64Number Kl, cmsFloat64Number Kc, cmsFloat64Number Kh);

// Temperature <-> Chromaticity (Black body)
cmsBool cmsWhitePointFromTemp (cmsCIExyY* WhitePoint, cmsFloat64Number TempK);
cmsBool cmsTempFromWhitePoint (cmsFloat64Number* TempK, const(cmsCIExyY)* WhitePoint);

// Chromatic adaptation
cmsBool cmsAdaptToIlluminant (
    cmsCIEXYZ* Result,
    const(cmsCIEXYZ)* SourceWhitePt,
    const(cmsCIEXYZ)* Illuminant,
    const(cmsCIEXYZ)* Value);

// CIECAM02 ---------------------------------------------------------------------------------------------------

// Viewing conditions. Please note those are CAM model viewing conditions, and not the ICC tag viewing
// conditions, which I'm naming cmsICCViewingConditions to make differences evident. Unfortunately, the tag
// cannot deal with surround La, Yb and D value so is basically useless to store CAM02 viewing conditions.

struct cmsViewingConditions
{
    cmsCIEXYZ whitePoint;
    cmsFloat64Number Yb;
    cmsFloat64Number La;
    cmsUInt32Number surround;
    cmsFloat64Number D_value;
}

cmsHANDLE cmsCIECAM02Init (cmsContext ContextID, const(cmsViewingConditions)* pVC);
void cmsCIECAM02Done (cmsHANDLE hModel);
void cmsCIECAM02Forward (cmsHANDLE hModel, const(cmsCIEXYZ)* pIn, cmsJCh* pOut);
void cmsCIECAM02Reverse (cmsHANDLE hModel, const(cmsJCh)* pIn, cmsCIEXYZ* pOut);

// Tone curves -----------------------------------------------------------------------------------------

// This describes a curve segment. For a table of supported types, see the manual. User can increase the number of
// available types by using a proper plug-in. Parametric segments allow 10 parameters at most

struct cmsCurveSegment
{
    cmsFloat32Number x0;
    cmsFloat32Number x1; // Domain; for x0 < x <= x1
    cmsInt32Number Type; // Parametric type, Type == 0 means sampled segment. Negative values are reserved
    cmsFloat64Number[10] Params; // Parameters if Type != 0
    cmsUInt32Number nGridPoints; // Number of grid points if Type == 0
    cmsFloat32Number* SampledPoints; // Points to an array of floats if Type == 0
}

// The internal representation is none of your business.
struct _cms_curve_struct;
alias cmsToneCurve = _cms_curve_struct;

cmsToneCurve* cmsBuildSegmentedToneCurve (cmsContext ContextID, cmsUInt32Number nSegments, const(cmsCurveSegment)* Segments);
cmsToneCurve* cmsBuildParametricToneCurve (cmsContext ContextID, cmsInt32Number Type, const(cmsFloat64Number)* Params);
cmsToneCurve* cmsBuildGamma (cmsContext ContextID, cmsFloat64Number Gamma);
cmsToneCurve* cmsBuildTabulatedToneCurve16 (cmsContext ContextID, cmsUInt32Number nEntries, const(cmsUInt16Number)* values);
cmsToneCurve* cmsBuildTabulatedToneCurveFloat (cmsContext ContextID, cmsUInt32Number nEntries, const(cmsFloat32Number)* values);
void cmsFreeToneCurve (cmsToneCurve* Curve);
void cmsFreeToneCurveTriple (ref cmsToneCurve*[3] Curve);
cmsToneCurve* cmsDupToneCurve (const(cmsToneCurve)* Src);
cmsToneCurve* cmsReverseToneCurve (const(cmsToneCurve)* InGamma);
cmsToneCurve* cmsReverseToneCurveEx (cmsUInt32Number nResultSamples, const(cmsToneCurve)* InGamma);
cmsToneCurve* cmsJoinToneCurve (cmsContext ContextID, const(cmsToneCurve)* X, const(cmsToneCurve)* Y, cmsUInt32Number nPoints);
cmsBool cmsSmoothToneCurve (cmsToneCurve* Tab, cmsFloat64Number lambda);
cmsFloat32Number cmsEvalToneCurveFloat (const(cmsToneCurve)* Curve, cmsFloat32Number v);
cmsUInt16Number cmsEvalToneCurve16 (const(cmsToneCurve)* Curve, cmsUInt16Number v);
cmsBool cmsIsToneCurveMultisegment (const(cmsToneCurve)* InGamma);
cmsBool cmsIsToneCurveLinear (const(cmsToneCurve)* Curve);
cmsBool cmsIsToneCurveMonotonic (const(cmsToneCurve)* t);
cmsBool cmsIsToneCurveDescending (const(cmsToneCurve)* t);
cmsInt32Number cmsGetToneCurveParametricType (const(cmsToneCurve)* t);
cmsFloat64Number cmsEstimateGamma (const(cmsToneCurve)* t, cmsFloat64Number Precision);
cmsFloat64Number* cmsGetToneCurveParams (const(cmsToneCurve)* t);

// Tone curve tabular estimation
cmsUInt32Number cmsGetToneCurveEstimatedTableEntries (const(cmsToneCurve)* t);
const(cmsUInt16Number)* cmsGetToneCurveEstimatedTable (const(cmsToneCurve)* t);

// Implements pipelines of multi-processing elements -------------------------------------------------------------

// Nothing to see here, move along
struct _cmsPipeline_struct;
alias cmsPipeline = _cmsPipeline_struct;
struct _cmsStage_struct;
alias cmsStage = _cmsStage_struct;

// Those are hi-level pipelines
cmsPipeline* cmsPipelineAlloc (cmsContext ContextID, cmsUInt32Number InputChannels, cmsUInt32Number OutputChannels);
void cmsPipelineFree (cmsPipeline* lut);
cmsPipeline* cmsPipelineDup (const(cmsPipeline)* Orig);

cmsContext cmsGetPipelineContextID (const(cmsPipeline)* lut);
cmsUInt32Number cmsPipelineInputChannels (const(cmsPipeline)* lut);
cmsUInt32Number cmsPipelineOutputChannels (const(cmsPipeline)* lut);

cmsUInt32Number cmsPipelineStageCount (const(cmsPipeline)* lut);
cmsStage* cmsPipelineGetPtrToFirstStage (const(cmsPipeline)* lut);
cmsStage* cmsPipelineGetPtrToLastStage (const(cmsPipeline)* lut);

void cmsPipelineEval16 (const(cmsUInt16Number)* In, cmsUInt16Number* Out, const(cmsPipeline)* lut);
void cmsPipelineEvalFloat (const(cmsFloat32Number)* In, cmsFloat32Number* Out, const(cmsPipeline)* lut);
cmsBool cmsPipelineEvalReverseFloat (cmsFloat32Number* Target, cmsFloat32Number* Result, cmsFloat32Number* Hint, const(cmsPipeline)* lut);
cmsBool cmsPipelineCat (cmsPipeline* l1, const(cmsPipeline)* l2);
cmsBool cmsPipelineSetSaveAs8bitsFlag (cmsPipeline* lut, cmsBool On);

// Where to place/locate the stages in the pipeline chain
enum cmsStageLoc
{
    cmsAT_BEGIN = 0,
    cmsAT_END = 1
}

cmsBool cmsPipelineInsertStage (cmsPipeline* lut, cmsStageLoc loc, cmsStage* mpe);
void cmsPipelineUnlinkStage (cmsPipeline* lut, cmsStageLoc loc, cmsStage** mpe);

// This function is quite useful to analyze the structure of a Pipeline and retrieve the Stage elements
// that conform the Pipeline. It should be called with the Pipeline, the number of expected elements and
// then a list of expected types followed with a list of double pointers to Stage elements. If
// the function founds a match with current pipeline, it fills the pointers and returns TRUE
// if not, returns FALSE without touching anything.
cmsBool cmsPipelineCheckAndRetreiveStages (const(cmsPipeline)* Lut, cmsUInt32Number n, ...);

// Matrix has double precision and CLUT has only float precision. That is because an ICC profile can encode
// matrices with far more precision that CLUTS
cmsStage* cmsStageAllocIdentity (cmsContext ContextID, cmsUInt32Number nChannels);
cmsStage* cmsStageAllocToneCurves (cmsContext ContextID, cmsUInt32Number nChannels, const(cmsToneCurve*)* Curves);
cmsStage* cmsStageAllocMatrix (cmsContext ContextID, cmsUInt32Number Rows, cmsUInt32Number Cols, const(cmsFloat64Number)* Matrix, const(cmsFloat64Number)* Offset);

cmsStage* cmsStageAllocCLut16bit (cmsContext ContextID, cmsUInt32Number nGridPoints, cmsUInt32Number inputChan, cmsUInt32Number outputChan, const(cmsUInt16Number)* Table);
cmsStage* cmsStageAllocCLutFloat (cmsContext ContextID, cmsUInt32Number nGridPoints, cmsUInt32Number inputChan, cmsUInt32Number outputChan, const(cmsFloat32Number)* Table);

cmsStage* cmsStageAllocCLut16bitGranular (cmsContext ContextID, const(cmsUInt32Number)* clutPoints, cmsUInt32Number inputChan, cmsUInt32Number outputChan, const(cmsUInt16Number)* Table);
cmsStage* cmsStageAllocCLutFloatGranular (cmsContext ContextID, const(cmsUInt32Number)* clutPoints, cmsUInt32Number inputChan, cmsUInt32Number outputChan, const(cmsFloat32Number)* Table);

cmsStage* cmsStageDup (cmsStage* mpe);
void cmsStageFree (cmsStage* mpe);
cmsStage* cmsStageNext (const(cmsStage)* mpe);

cmsUInt32Number cmsStageInputChannels (const(cmsStage)* mpe);
cmsUInt32Number cmsStageOutputChannels (const(cmsStage)* mpe);
cmsStageSignature cmsStageType (const(cmsStage)* mpe);
void* cmsStageData (const(cmsStage)* mpe);
cmsContext cmsGetStageContextID (const(cmsStage)* mpe);

// Sampling
alias cmsSAMPLER16 = int function (
    const(cmsUInt16Number)[] In,
    cmsUInt16Number[] Out,
    void* Cargo);

alias cmsSAMPLERFLOAT = int function (
    const(cmsFloat32Number)[] In,
    cmsFloat32Number[] Out,
    void* Cargo);

// Use this flag to prevent changes being written to destination

// For CLUT only
cmsBool cmsStageSampleCLut16bit (cmsStage* mpe, cmsSAMPLER16 Sampler, void* Cargo, cmsUInt32Number dwFlags);
cmsBool cmsStageSampleCLutFloat (cmsStage* mpe, cmsSAMPLERFLOAT Sampler, void* Cargo, cmsUInt32Number dwFlags);

// Slicers
cmsBool cmsSliceSpace16 (
    cmsUInt32Number nInputs,
    const(cmsUInt32Number)* clutPoints,
    cmsSAMPLER16 Sampler,
    void* Cargo);

cmsBool cmsSliceSpaceFloat (
    cmsUInt32Number nInputs,
    const(cmsUInt32Number)* clutPoints,
    cmsSAMPLERFLOAT Sampler,
    void* Cargo);

// Multilocalized Unicode management ---------------------------------------------------------------------------------------

struct _cms_MLU_struct;
alias cmsMLU = _cms_MLU_struct;

cmsMLU* cmsMLUalloc (cmsContext ContextID, cmsUInt32Number nItems);
void cmsMLUfree (cmsMLU* mlu);
cmsMLU* cmsMLUdup (const(cmsMLU)* mlu);

cmsBool cmsMLUsetASCII (
    cmsMLU* mlu,
    ref const(char)[3] LanguageCode,
    ref const(char)[3] CountryCode,
    const(char)* ASCIIString);
cmsBool cmsMLUsetWide (
    cmsMLU* mlu,
    ref const(char)[3] LanguageCode,
    ref const(char)[3] CountryCode,
    const(wchar_t)* WideString);

cmsUInt32Number cmsMLUgetASCII (
    const(cmsMLU)* mlu,
    ref const(char)[3] LanguageCode,
    ref const(char)[3] CountryCode,
    char* Buffer,
    cmsUInt32Number BufferSize);

cmsUInt32Number cmsMLUgetWide (
    const(cmsMLU)* mlu,
    ref const(char)[3] LanguageCode,
    ref const(char)[3] CountryCode,
    wchar_t* Buffer,
    cmsUInt32Number BufferSize);

cmsBool cmsMLUgetTranslation (
    const(cmsMLU)* mlu,
    ref const(char)[3] LanguageCode,
    ref const(char)[3] CountryCode,
    ref char[3] ObtainedLanguage,
    ref char[3] ObtainedCountry);

cmsUInt32Number cmsMLUtranslationsCount (const(cmsMLU)* mlu);

cmsBool cmsMLUtranslationsCodes (
    const(cmsMLU)* mlu,
    cmsUInt32Number idx,
    ref char[3] LanguageCode,
    ref char[3] CountryCode);

// Undercolorremoval & black generation -------------------------------------------------------------------------------------

struct cmsUcrBg
{
    cmsToneCurve* Ucr;
    cmsToneCurve* Bg;
    cmsMLU* Desc;
}

// Screening ----------------------------------------------------------------------------------------------------------------

struct cmsScreeningChannel
{
    cmsFloat64Number Frequency;
    cmsFloat64Number ScreenAngle;
    cmsUInt32Number SpotShape;
}

struct cmsScreening
{
    cmsUInt32Number Flag;
    cmsUInt32Number nChannels;
    cmsScreeningChannel[cmsMAXCHANNELS] Channels;
}

// Named color -----------------------------------------------------------------------------------------------------------------

struct _cms_NAMEDCOLORLIST_struct;
alias cmsNAMEDCOLORLIST = _cms_NAMEDCOLORLIST_struct;

cmsNAMEDCOLORLIST* cmsAllocNamedColorList (
    cmsContext ContextID,
    cmsUInt32Number n,
    cmsUInt32Number ColorantCount,
    const(char)* Prefix,
    const(char)* Suffix);

void cmsFreeNamedColorList (cmsNAMEDCOLORLIST* v);
cmsNAMEDCOLORLIST* cmsDupNamedColorList (const(cmsNAMEDCOLORLIST)* v);
cmsBool cmsAppendNamedColor (
    cmsNAMEDCOLORLIST* v,
    const(char)* Name,
    ref cmsUInt16Number[3] PCS,
    ref cmsUInt16Number[cmsMAXCHANNELS] Colorant);

cmsUInt32Number cmsNamedColorCount (const(cmsNAMEDCOLORLIST)* v);
cmsInt32Number cmsNamedColorIndex (const(cmsNAMEDCOLORLIST)* v, const(char)* Name);

cmsBool cmsNamedColorInfo (
    const(cmsNAMEDCOLORLIST)* NamedColorList,
    cmsUInt32Number nColor,
    char* Name,
    char* Prefix,
    char* Suffix,
    cmsUInt16Number* PCS,
    cmsUInt16Number* Colorant);

// Retrieve named color list from transform
cmsNAMEDCOLORLIST* cmsGetNamedColorList (cmsHTRANSFORM xform);

// Profile sequence -----------------------------------------------------------------------------------------------------

// Profile sequence descriptor. Some fields come from profile sequence descriptor tag, others
// come from Profile Sequence Identifier Tag
struct cmsPSEQDESC
{
    cmsSignature deviceMfg;
    cmsSignature deviceModel;
    cmsUInt64Number attributes;
    cmsTechnologySignature technology;
    cmsProfileID ProfileID;
    cmsMLU* Manufacturer;
    cmsMLU* Model;
    cmsMLU* Description;
}

struct cmsSEQ
{
    cmsUInt32Number n;
    cmsContext ContextID;
    cmsPSEQDESC* seq;
}

cmsSEQ* cmsAllocProfileSequenceDescription (cmsContext ContextID, cmsUInt32Number n);
cmsSEQ* cmsDupProfileSequenceDescription (const(cmsSEQ)* pseq);
void cmsFreeProfileSequenceDescription (cmsSEQ* pseq);

// Dictionaries --------------------------------------------------------------------------------------------------------

struct _cmsDICTentry_struct
{
    _cmsDICTentry_struct* Next;

    cmsMLU* DisplayName;
    cmsMLU* DisplayValue;
    wchar_t* Name;
    wchar_t* Value;
}

alias cmsDICTentry = _cmsDICTentry_struct;

cmsHANDLE cmsDictAlloc (cmsContext ContextID);
void cmsDictFree (cmsHANDLE hDict);
cmsHANDLE cmsDictDup (cmsHANDLE hDict);

cmsBool cmsDictAddEntry (cmsHANDLE hDict, const(wchar_t)* Name, const(wchar_t)* Value, const(cmsMLU)* DisplayName, const(cmsMLU)* DisplayValue);
const(cmsDICTentry)* cmsDictGetEntryList (cmsHANDLE hDict);
const(cmsDICTentry)* cmsDictNextEntry (const(cmsDICTentry)* e);

// Access to Profile data ----------------------------------------------------------------------------------------------
cmsHPROFILE cmsCreateProfilePlaceholder (cmsContext ContextID);

cmsContext cmsGetProfileContextID (cmsHPROFILE hProfile);
cmsInt32Number cmsGetTagCount (cmsHPROFILE hProfile);
cmsTagSignature cmsGetTagSignature (cmsHPROFILE hProfile, cmsUInt32Number n);
cmsBool cmsIsTag (cmsHPROFILE hProfile, cmsTagSignature sig);

// Read and write pre-formatted data
void* cmsReadTag (cmsHPROFILE hProfile, cmsTagSignature sig);
cmsBool cmsWriteTag (cmsHPROFILE hProfile, cmsTagSignature sig, const(void)* data);
cmsBool cmsLinkTag (cmsHPROFILE hProfile, cmsTagSignature sig, cmsTagSignature dest);
cmsTagSignature cmsTagLinkedTo (cmsHPROFILE hProfile, cmsTagSignature sig);

// Read and write raw data
cmsUInt32Number cmsReadRawTag (cmsHPROFILE hProfile, cmsTagSignature sig, void* Buffer, cmsUInt32Number BufferSize);
cmsBool cmsWriteRawTag (cmsHPROFILE hProfile, cmsTagSignature sig, const(void)* data, cmsUInt32Number Size);

// Access header data

cmsUInt32Number cmsGetHeaderFlags (cmsHPROFILE hProfile);
void cmsGetHeaderAttributes (cmsHPROFILE hProfile, cmsUInt64Number* Flags);
void cmsGetHeaderProfileID (cmsHPROFILE hProfile, cmsUInt8Number* ProfileID);
cmsBool cmsGetHeaderCreationDateTime (cmsHPROFILE hProfile, tm* Dest);
cmsUInt32Number cmsGetHeaderRenderingIntent (cmsHPROFILE hProfile);

void cmsSetHeaderFlags (cmsHPROFILE hProfile, cmsUInt32Number Flags);
cmsUInt32Number cmsGetHeaderManufacturer (cmsHPROFILE hProfile);
void cmsSetHeaderManufacturer (cmsHPROFILE hProfile, cmsUInt32Number manufacturer);
cmsUInt32Number cmsGetHeaderCreator (cmsHPROFILE hProfile);
cmsUInt32Number cmsGetHeaderModel (cmsHPROFILE hProfile);
void cmsSetHeaderModel (cmsHPROFILE hProfile, cmsUInt32Number model);
void cmsSetHeaderAttributes (cmsHPROFILE hProfile, cmsUInt64Number Flags);
void cmsSetHeaderProfileID (cmsHPROFILE hProfile, cmsUInt8Number* ProfileID);
void cmsSetHeaderRenderingIntent (cmsHPROFILE hProfile, cmsUInt32Number RenderingIntent);

cmsColorSpaceSignature cmsGetPCS (cmsHPROFILE hProfile);
void cmsSetPCS (cmsHPROFILE hProfile, cmsColorSpaceSignature pcs);
cmsColorSpaceSignature cmsGetColorSpace (cmsHPROFILE hProfile);
void cmsSetColorSpace (cmsHPROFILE hProfile, cmsColorSpaceSignature sig);
cmsProfileClassSignature cmsGetDeviceClass (cmsHPROFILE hProfile);
void cmsSetDeviceClass (cmsHPROFILE hProfile, cmsProfileClassSignature sig);
void cmsSetProfileVersion (cmsHPROFILE hProfile, cmsFloat64Number Version);
cmsFloat64Number cmsGetProfileVersion (cmsHPROFILE hProfile);

cmsUInt32Number cmsGetEncodedICCversion (cmsHPROFILE hProfile);
void cmsSetEncodedICCversion (cmsHPROFILE hProfile, cmsUInt32Number Version);

// How profiles may be used

cmsBool cmsIsIntentSupported (cmsHPROFILE hProfile, cmsUInt32Number Intent, cmsUInt32Number UsedDirection);
cmsBool cmsIsMatrixShaper (cmsHPROFILE hProfile);
cmsBool cmsIsCLUT (cmsHPROFILE hProfile, cmsUInt32Number Intent, cmsUInt32Number UsedDirection);

// Translate form/to our notation to ICC
cmsColorSpaceSignature _cmsICCcolorSpace (int OurNotation);
int _cmsLCMScolorSpace (cmsColorSpaceSignature ProfileSpace);

cmsUInt32Number cmsChannelsOf (cmsColorSpaceSignature ColorSpace);

// Build a suitable formatter for the colorspace of this profile. nBytes=1 means 8 bits, nBytes=2 means 16 bits. 
cmsUInt32Number cmsFormatterForColorspaceOfProfile (cmsHPROFILE hProfile, cmsUInt32Number nBytes, cmsBool lIsFloat);
cmsUInt32Number cmsFormatterForPCSOfProfile (cmsHPROFILE hProfile, cmsUInt32Number nBytes, cmsBool lIsFloat);

// Localized info
enum cmsInfoType
{
    cmsInfoDescription = 0,
    cmsInfoManufacturer = 1,
    cmsInfoModel = 2,
    cmsInfoCopyright = 3
}

cmsUInt32Number cmsGetProfileInfo (
    cmsHPROFILE hProfile,
    cmsInfoType Info,
    ref const(char)[3] LanguageCode,
    ref const(char)[3] CountryCode,
    wchar_t* Buffer,
    cmsUInt32Number BufferSize);

cmsUInt32Number cmsGetProfileInfoASCII (
    cmsHPROFILE hProfile,
    cmsInfoType Info,
    ref const(char)[3] LanguageCode,
    ref const(char)[3] CountryCode,
    char* Buffer,
    cmsUInt32Number BufferSize);

// IO handlers ----------------------------------------------------------------------------------------------------------

struct _cms_io_handler;
alias cmsIOHANDLER = _cms_io_handler;

cmsIOHANDLER* cmsOpenIOhandlerFromFile (cmsContext ContextID, const(char)* FileName, const(char)* AccessMode);
cmsIOHANDLER* cmsOpenIOhandlerFromStream (cmsContext ContextID, FILE* Stream);
cmsIOHANDLER* cmsOpenIOhandlerFromMem (cmsContext ContextID, void* Buffer, cmsUInt32Number size, const(char)* AccessMode);
cmsIOHANDLER* cmsOpenIOhandlerFromNULL (cmsContext ContextID);
cmsIOHANDLER* cmsGetProfileIOhandler (cmsHPROFILE hProfile);
cmsBool cmsCloseIOhandler (cmsIOHANDLER* io);

// MD5 message digest --------------------------------------------------------------------------------------------------

cmsBool cmsMD5computeID (cmsHPROFILE hProfile);

// Profile high level functions ------------------------------------------------------------------------------------------

cmsHPROFILE cmsOpenProfileFromFile (const(char)* ICCProfile, const(char)* sAccess);
cmsHPROFILE cmsOpenProfileFromFileTHR (cmsContext ContextID, const(char)* ICCProfile, const(char)* sAccess);
cmsHPROFILE cmsOpenProfileFromStream (FILE* ICCProfile, const(char)* sAccess);
cmsHPROFILE cmsOpenProfileFromStreamTHR (cmsContext ContextID, FILE* ICCProfile, const(char)* sAccess);
cmsHPROFILE cmsOpenProfileFromMem (const(void)* MemPtr, cmsUInt32Number dwSize);
cmsHPROFILE cmsOpenProfileFromMemTHR (cmsContext ContextID, const(void)* MemPtr, cmsUInt32Number dwSize);
cmsHPROFILE cmsOpenProfileFromIOhandlerTHR (cmsContext ContextID, cmsIOHANDLER* io);
cmsHPROFILE cmsOpenProfileFromIOhandler2THR (cmsContext ContextID, cmsIOHANDLER* io, cmsBool write);
cmsBool cmsCloseProfile (cmsHPROFILE hProfile);

cmsBool cmsSaveProfileToFile (cmsHPROFILE hProfile, const(char)* FileName);
cmsBool cmsSaveProfileToStream (cmsHPROFILE hProfile, FILE* Stream);
cmsBool cmsSaveProfileToMem (cmsHPROFILE hProfile, void* MemPtr, cmsUInt32Number* BytesNeeded);
cmsUInt32Number cmsSaveProfileToIOhandler (cmsHPROFILE hProfile, cmsIOHANDLER* io);

// Predefined virtual profiles ------------------------------------------------------------------------------------------

cmsHPROFILE cmsCreateRGBProfileTHR (
    cmsContext ContextID,
    const(cmsCIExyY)* WhitePoint,
    const(cmsCIExyYTRIPLE)* Primaries,
    ref const(cmsToneCurve*)[3] TransferFunction);

cmsHPROFILE cmsCreateRGBProfile (
    const(cmsCIExyY)* WhitePoint,
    const(cmsCIExyYTRIPLE)* Primaries,
    ref const(cmsToneCurve*)[3] TransferFunction);

cmsHPROFILE cmsCreateGrayProfileTHR (
    cmsContext ContextID,
    const(cmsCIExyY)* WhitePoint,
    const(cmsToneCurve)* TransferFunction);

cmsHPROFILE cmsCreateGrayProfile (
    const(cmsCIExyY)* WhitePoint,
    const(cmsToneCurve)* TransferFunction);

cmsHPROFILE cmsCreateLinearizationDeviceLinkTHR (
    cmsContext ContextID,
    cmsColorSpaceSignature ColorSpace,
    const(cmsToneCurve*)* TransferFunctions);

cmsHPROFILE cmsCreateLinearizationDeviceLink (
    cmsColorSpaceSignature ColorSpace,
    const(cmsToneCurve*)* TransferFunctions);

cmsHPROFILE cmsCreateInkLimitingDeviceLinkTHR (
    cmsContext ContextID,
    cmsColorSpaceSignature ColorSpace,
    cmsFloat64Number Limit);

cmsHPROFILE cmsCreateInkLimitingDeviceLink (cmsColorSpaceSignature ColorSpace, cmsFloat64Number Limit);

cmsHPROFILE cmsCreateLab2ProfileTHR (cmsContext ContextID, const(cmsCIExyY)* WhitePoint);
cmsHPROFILE cmsCreateLab2Profile (const(cmsCIExyY)* WhitePoint);
cmsHPROFILE cmsCreateLab4ProfileTHR (cmsContext ContextID, const(cmsCIExyY)* WhitePoint);
cmsHPROFILE cmsCreateLab4Profile (const(cmsCIExyY)* WhitePoint);

cmsHPROFILE cmsCreateXYZProfileTHR (cmsContext ContextID);
cmsHPROFILE cmsCreateXYZProfile ();

cmsHPROFILE cmsCreate_sRGBProfileTHR (cmsContext ContextID);
cmsHPROFILE cmsCreate_sRGBProfile ();

cmsHPROFILE cmsCreateBCHSWabstractProfileTHR (
    cmsContext ContextID,
    cmsUInt32Number nLUTPoints,
    cmsFloat64Number Bright,
    cmsFloat64Number Contrast,
    cmsFloat64Number Hue,
    cmsFloat64Number Saturation,
    cmsUInt32Number TempSrc,
    cmsUInt32Number TempDest);

cmsHPROFILE cmsCreateBCHSWabstractProfile (
    cmsUInt32Number nLUTPoints,
    cmsFloat64Number Bright,
    cmsFloat64Number Contrast,
    cmsFloat64Number Hue,
    cmsFloat64Number Saturation,
    cmsUInt32Number TempSrc,
    cmsUInt32Number TempDest);

cmsHPROFILE cmsCreateNULLProfileTHR (cmsContext ContextID);
cmsHPROFILE cmsCreateNULLProfile ();

// Converts a transform to a devicelink profile
cmsHPROFILE cmsTransform2DeviceLink (cmsHTRANSFORM hTransform, cmsFloat64Number Version, cmsUInt32Number dwFlags);

// Intents ----------------------------------------------------------------------------------------------

// ICC Intents

// Non-ICC intents

// Call with NULL as parameters to get the intent count
cmsUInt32Number cmsGetSupportedIntents (cmsUInt32Number nMax, cmsUInt32Number* Codes, char** Descriptions);
cmsUInt32Number cmsGetSupportedIntentsTHR (cmsContext ContextID, cmsUInt32Number nMax, cmsUInt32Number* Codes, char** Descriptions);

// Flags

// Inhibit 1-pixel cache
// Inhibit optimizations
// Don't transform anyway

// Proofing flags
// Out of Gamut alarm
// Do softproofing

// Misc

// Don't fix scum dot
// Use more memory to give better accuracy
// Use less memory to minimize resources

// For devicelink creation
// Create 8 bits devicelinks
// Guess device class (for transform2devicelink)
// Keep profile sequence for devicelink creation

// Specific to a particular optimizations
// Force CLUT optimization
// create postlinearization tables if possible
// create prelinearization tables if possible

// Specific to unbounded mode
// Prevent negative numbers in floating point transforms

// Copy alpha channels when transforming           
// Alpha channels are copied on cmsDoTransform()

// Fine-tune control over number of gridpoints

// CRD special

// Transforms ---------------------------------------------------------------------------------------------------

cmsHTRANSFORM cmsCreateTransformTHR (
    cmsContext ContextID,
    cmsHPROFILE Input,
    cmsUInt32Number InputFormat,
    cmsHPROFILE Output,
    cmsUInt32Number OutputFormat,
    cmsUInt32Number Intent,
    cmsUInt32Number dwFlags);

cmsHTRANSFORM cmsCreateTransform (
    cmsHPROFILE Input,
    cmsUInt32Number InputFormat,
    cmsHPROFILE Output,
    cmsUInt32Number OutputFormat,
    cmsUInt32Number Intent,
    cmsUInt32Number dwFlags);

cmsHTRANSFORM cmsCreateProofingTransformTHR (
    cmsContext ContextID,
    cmsHPROFILE Input,
    cmsUInt32Number InputFormat,
    cmsHPROFILE Output,
    cmsUInt32Number OutputFormat,
    cmsHPROFILE Proofing,
    cmsUInt32Number Intent,
    cmsUInt32Number ProofingIntent,
    cmsUInt32Number dwFlags);

cmsHTRANSFORM cmsCreateProofingTransform (
    cmsHPROFILE Input,
    cmsUInt32Number InputFormat,
    cmsHPROFILE Output,
    cmsUInt32Number OutputFormat,
    cmsHPROFILE Proofing,
    cmsUInt32Number Intent,
    cmsUInt32Number ProofingIntent,
    cmsUInt32Number dwFlags);

cmsHTRANSFORM cmsCreateMultiprofileTransformTHR (
    cmsContext ContextID,
    cmsHPROFILE* hProfiles,
    cmsUInt32Number nProfiles,
    cmsUInt32Number InputFormat,
    cmsUInt32Number OutputFormat,
    cmsUInt32Number Intent,
    cmsUInt32Number dwFlags);

cmsHTRANSFORM cmsCreateMultiprofileTransform (
    cmsHPROFILE* hProfiles,
    cmsUInt32Number nProfiles,
    cmsUInt32Number InputFormat,
    cmsUInt32Number OutputFormat,
    cmsUInt32Number Intent,
    cmsUInt32Number dwFlags);

cmsHTRANSFORM cmsCreateExtendedTransform (
    cmsContext ContextID,
    cmsUInt32Number nProfiles,
    cmsHPROFILE* hProfiles,
    cmsBool* BPC,
    cmsUInt32Number* Intents,
    cmsFloat64Number* AdaptationStates,
    cmsHPROFILE hGamutProfile,
    cmsUInt32Number nGamutPCSposition,
    cmsUInt32Number InputFormat,
    cmsUInt32Number OutputFormat,
    cmsUInt32Number dwFlags);

void cmsDeleteTransform (cmsHTRANSFORM hTransform);

void cmsDoTransform (
    cmsHTRANSFORM Transform,
    const(void)* InputBuffer,
    void* OutputBuffer,
    cmsUInt32Number Size);

// Deprecated
void cmsDoTransformStride (
    cmsHTRANSFORM Transform,
    const(void)* InputBuffer,
    void* OutputBuffer,
    cmsUInt32Number Size,
    cmsUInt32Number Stride);

void cmsDoTransformLineStride (
    cmsHTRANSFORM Transform,
    const(void)* InputBuffer,
    void* OutputBuffer,
    cmsUInt32Number PixelsPerLine,
    cmsUInt32Number LineCount,
    cmsUInt32Number BytesPerLineIn,
    cmsUInt32Number BytesPerLineOut,
    cmsUInt32Number BytesPerPlaneIn,
    cmsUInt32Number BytesPerPlaneOut);

void cmsSetAlarmCodes (ref const(cmsUInt16Number)[cmsMAXCHANNELS] NewAlarm);
void cmsGetAlarmCodes (ref cmsUInt16Number[cmsMAXCHANNELS] NewAlarm);

void cmsSetAlarmCodesTHR (
    cmsContext ContextID,
    ref const(cmsUInt16Number)[cmsMAXCHANNELS] AlarmCodes);
void cmsGetAlarmCodesTHR (
    cmsContext ContextID,
    ref cmsUInt16Number[cmsMAXCHANNELS] AlarmCodes);

// Adaptation state for absolute colorimetric intent
cmsFloat64Number cmsSetAdaptationState (cmsFloat64Number d);
cmsFloat64Number cmsSetAdaptationStateTHR (cmsContext ContextID, cmsFloat64Number d);

// Grab the ContextID from an open transform. Returns NULL if a NULL transform is passed
cmsContext cmsGetTransformContextID (cmsHTRANSFORM hTransform);

// Grab the input/output formats
cmsUInt32Number cmsGetTransformInputFormat (cmsHTRANSFORM hTransform);
cmsUInt32Number cmsGetTransformOutputFormat (cmsHTRANSFORM hTransform);

// For backwards compatibility
cmsBool cmsChangeBuffersFormat (
    cmsHTRANSFORM hTransform,
    cmsUInt32Number InputFormat,
    cmsUInt32Number OutputFormat);

// PostScript ColorRenderingDictionary and ColorSpaceArray ----------------------------------------------------

enum cmsPSResourceType
{
    cmsPS_RESOURCE_CSA = 0,
    cmsPS_RESOURCE_CRD = 1
}

// lcms2 unified method to access postscript color resources
cmsUInt32Number cmsGetPostScriptColorResource (
    cmsContext ContextID,
    cmsPSResourceType Type,
    cmsHPROFILE hProfile,
    cmsUInt32Number Intent,
    cmsUInt32Number dwFlags,
    cmsIOHANDLER* io);

cmsUInt32Number cmsGetPostScriptCSA (cmsContext ContextID, cmsHPROFILE hProfile, cmsUInt32Number Intent, cmsUInt32Number dwFlags, void* Buffer, cmsUInt32Number dwBufferLen);
cmsUInt32Number cmsGetPostScriptCRD (cmsContext ContextID, cmsHPROFILE hProfile, cmsUInt32Number Intent, cmsUInt32Number dwFlags, void* Buffer, cmsUInt32Number dwBufferLen);

// IT8.7 / CGATS.17-200x handling -----------------------------------------------------------------------------

cmsHANDLE cmsIT8Alloc (cmsContext ContextID);
void cmsIT8Free (cmsHANDLE hIT8);

// Tables
cmsUInt32Number cmsIT8TableCount (cmsHANDLE hIT8);
cmsInt32Number cmsIT8SetTable (cmsHANDLE hIT8, cmsUInt32Number nTable);

// Persistence
cmsHANDLE cmsIT8LoadFromFile (cmsContext ContextID, const(char)* cFileName);
cmsHANDLE cmsIT8LoadFromMem (cmsContext ContextID, const(void)* Ptr, cmsUInt32Number len);
// CMSAPI cmsHANDLE        CMSEXPORT cmsIT8LoadFromIOhandler(cmsContext ContextID, cmsIOHANDLER* io);

cmsBool cmsIT8SaveToFile (cmsHANDLE hIT8, const(char)* cFileName);
cmsBool cmsIT8SaveToMem (cmsHANDLE hIT8, void* MemPtr, cmsUInt32Number* BytesNeeded);

// Properties
const(char)* cmsIT8GetSheetType (cmsHANDLE hIT8);
cmsBool cmsIT8SetSheetType (cmsHANDLE hIT8, const(char)* Type);

cmsBool cmsIT8SetComment (cmsHANDLE hIT8, const(char)* cComment);

cmsBool cmsIT8SetPropertyStr (cmsHANDLE hIT8, const(char)* cProp, const(char)* Str);
cmsBool cmsIT8SetPropertyDbl (cmsHANDLE hIT8, const(char)* cProp, cmsFloat64Number Val);
cmsBool cmsIT8SetPropertyHex (cmsHANDLE hIT8, const(char)* cProp, cmsUInt32Number Val);
cmsBool cmsIT8SetPropertyMulti (cmsHANDLE hIT8, const(char)* Key, const(char)* SubKey, const(char)* Buffer);
cmsBool cmsIT8SetPropertyUncooked (cmsHANDLE hIT8, const(char)* Key, const(char)* Buffer);

const(char)* cmsIT8GetProperty (cmsHANDLE hIT8, const(char)* cProp);
cmsFloat64Number cmsIT8GetPropertyDbl (cmsHANDLE hIT8, const(char)* cProp);
const(char)* cmsIT8GetPropertyMulti (cmsHANDLE hIT8, const(char)* Key, const(char)* SubKey);
cmsUInt32Number cmsIT8EnumProperties (cmsHANDLE hIT8, char*** PropertyNames);
cmsUInt32Number cmsIT8EnumPropertyMulti (cmsHANDLE hIT8, const(char)* cProp, const(char**)* SubpropertyNames);

// Datasets
const(char)* cmsIT8GetDataRowCol (cmsHANDLE hIT8, int row, int col);
cmsFloat64Number cmsIT8GetDataRowColDbl (cmsHANDLE hIT8, int row, int col);

cmsBool cmsIT8SetDataRowCol (
    cmsHANDLE hIT8,
    int row,
    int col,
    const(char)* Val);

cmsBool cmsIT8SetDataRowColDbl (
    cmsHANDLE hIT8,
    int row,
    int col,
    cmsFloat64Number Val);

const(char)* cmsIT8GetData (cmsHANDLE hIT8, const(char)* cPatch, const(char)* cSample);

cmsFloat64Number cmsIT8GetDataDbl (cmsHANDLE hIT8, const(char)* cPatch, const(char)* cSample);

cmsBool cmsIT8SetData (
    cmsHANDLE hIT8,
    const(char)* cPatch,
    const(char)* cSample,
    const(char)* Val);

cmsBool cmsIT8SetDataDbl (
    cmsHANDLE hIT8,
    const(char)* cPatch,
    const(char)* cSample,
    cmsFloat64Number Val);

int cmsIT8FindDataFormat (cmsHANDLE hIT8, const(char)* cSample);
cmsBool cmsIT8SetDataFormat (cmsHANDLE hIT8, int n, const(char)* Sample);
int cmsIT8EnumDataFormat (cmsHANDLE hIT8, char*** SampleNames);

const(char)* cmsIT8GetPatchName (cmsHANDLE hIT8, int nPatch, char* buffer);
int cmsIT8GetPatchByName (cmsHANDLE hIT8, const(char)* cPatch);

// The LABEL extension
int cmsIT8SetTableByLabel (cmsHANDLE hIT8, const(char)* cSet, const(char)* cField, const(char)* ExpectedType);

cmsBool cmsIT8SetIndexColumn (cmsHANDLE hIT8, const(char)* cSample);

// Formatter for double
void cmsIT8DefineDblFormat (cmsHANDLE hIT8, const(char)* Formatter);

// Gamut boundary description routines ------------------------------------------------------------------------------

cmsHANDLE cmsGBDAlloc (cmsContext ContextID);
void cmsGBDFree (cmsHANDLE hGBD);
cmsBool cmsGDBAddPoint (cmsHANDLE hGBD, const(cmsCIELab)* Lab);
cmsBool cmsGDBCompute (cmsHANDLE hGDB, cmsUInt32Number dwFlags);
cmsBool cmsGDBCheckPoint (cmsHANDLE hGBD, const(cmsCIELab)* Lab);

// Feature detection  ----------------------------------------------------------------------------------------------

// Estimate the black point
cmsBool cmsDetectBlackPoint (cmsCIEXYZ* BlackPoint, cmsHPROFILE hProfile, cmsUInt32Number Intent, cmsUInt32Number dwFlags);
cmsBool cmsDetectDestinationBlackPoint (cmsCIEXYZ* BlackPoint, cmsHPROFILE hProfile, cmsUInt32Number Intent, cmsUInt32Number dwFlags);

// Estimate total area coverage
cmsFloat64Number cmsDetectTAC (cmsHPROFILE hProfile);

// Estimate gamma space, always positive. Returns -1 on error.
cmsFloat64Number cmsDetectRGBProfileGamma (cmsHPROFILE hProfile, cmsFloat64Number threshold);

// Poor man's gamut mapping
cmsBool cmsDesaturateLab (
    cmsCIELab* Lab,
    double amax,
    double amin,
    double bmax,
    double bmin);
enum LCMS_VERSION = 2130;
enum cmsMAX_PATH = 256;
enum FALSE = 0;
enum TRUE = 1;
enum cmsD50X = 0.9642;
enum cmsD50Y = 1.0;
enum cmsD50Z = 0.8249;
enum cmsPERCEPTUAL_BLACK_X = 0.00336;
enum cmsPERCEPTUAL_BLACK_Y = 0.0034731;
enum cmsPERCEPTUAL_BLACK_Z = 0.00287;
enum cmsMagicNumber = 0x61637370;
enum lcmsSignature = 0x6c636d73;
enum cmsSigPerceptualReferenceMediumGamut = 0x70726d67;
enum cmsSigSceneColorimetryEstimates = 0x73636F65;
enum cmsSigSceneAppearanceEstimates = 0x73617065;
enum cmsSigFocalPlaneColorimetryEstimates = 0x66706365;
enum cmsSigReflectionHardcopyOriginalColorimetry = 0x72686F63;
enum cmsSigReflectionPrintOutputColorimetry = 0x72706F63;
enum cmsSigStatusA = 0x53746141;
enum cmsSigStatusE = 0x53746145;
enum cmsSigStatusI = 0x53746149;
enum cmsSigStatusT = 0x53746154;
enum cmsSigStatusM = 0x5374614D;
enum cmsSigDN = 0x444E2020;
enum cmsSigDNP = 0x444E2050;
enum cmsSigDNN = 0x444E4E20;
enum cmsSigDNNP = 0x444E4E50;
enum cmsReflective = 0;
enum cmsTransparency = 1;
enum cmsGlossy = 0;
enum cmsMatte = 2;
enum cmsMAXCHANNELS = 16;

extern (D) auto PREMUL_SH(T)(auto ref T m)
{
    return m << 23;
}

extern (D) auto FLOAT_SH(T)(auto ref T a)
{
    return a << 22;
}

extern (D) auto OPTIMIZED_SH(T)(auto ref T s)
{
    return s << 21;
}

extern (D) auto COLORSPACE_SH(T)(auto ref T s)
{
    return s << 16;
}

extern (D) auto SWAPFIRST_SH(T)(auto ref T s)
{
    return s << 14;
}

extern (D) auto FLAVOR_SH(T)(auto ref T s)
{
    return s << 13;
}

extern (D) auto PLANAR_SH(T)(auto ref T p)
{
    return p << 12;
}

extern (D) auto ENDIAN16_SH(T)(auto ref T e)
{
    return e << 11;
}

extern (D) auto DOSWAP_SH(T)(auto ref T e)
{
    return e << 10;
}

extern (D) auto EXTRA_SH(T)(auto ref T e)
{
    return e << 7;
}

extern (D) auto CHANNELS_SH(T)(auto ref T c)
{
    return c << 3;
}

extern (D) auto BYTES_SH(T)(auto ref T b)
{
    return b;
}

extern (D) auto T_PREMUL(T)(auto ref T m)
{
    return (m >> 23) & 1;
}

extern (D) auto T_FLOAT(T)(auto ref T a)
{
    return (a >> 22) & 1;
}

extern (D) auto T_OPTIMIZED(T)(auto ref T o)
{
    return (o >> 21) & 1;
}

extern (D) auto T_COLORSPACE(T)(auto ref T s)
{
    return (s >> 16) & 31;
}

extern (D) auto T_SWAPFIRST(T)(auto ref T s)
{
    return (s >> 14) & 1;
}

extern (D) auto T_FLAVOR(T)(auto ref T s)
{
    return (s >> 13) & 1;
}

extern (D) auto T_PLANAR(T)(auto ref T p)
{
    return (p >> 12) & 1;
}

extern (D) auto T_ENDIAN16(T)(auto ref T e)
{
    return (e >> 11) & 1;
}

extern (D) auto T_DOSWAP(T)(auto ref T e)
{
    return (e >> 10) & 1;
}

extern (D) auto T_EXTRA(T)(auto ref T e)
{
    return (e >> 7) & 7;
}

extern (D) auto T_CHANNELS(T)(auto ref T c)
{
    return (c >> 3) & 15;
}

extern (D) auto T_BYTES(T)(auto ref T b)
{
    return b & 7;
}

enum PT_ANY = 0;
enum PT_GRAY = 3;
enum PT_RGB = 4;
enum PT_CMY = 5;
enum PT_CMYK = 6;
enum PT_YCbCr = 7;
enum PT_YUV = 8;
enum PT_XYZ = 9;
enum PT_Lab = 10;
enum PT_YUVK = 11;
enum PT_HSV = 12;
enum PT_HLS = 13;
enum PT_Yxy = 14;
enum PT_MCH1 = 15;
enum PT_MCH2 = 16;
enum PT_MCH3 = 17;
enum PT_MCH4 = 18;
enum PT_MCH5 = 19;
enum PT_MCH6 = 20;
enum PT_MCH7 = 21;
enum PT_MCH8 = 22;
enum PT_MCH9 = 23;
enum PT_MCH10 = 24;
enum PT_MCH11 = 25;
enum PT_MCH12 = 26;
enum PT_MCH13 = 27;
enum PT_MCH14 = 28;
enum PT_MCH15 = 29;
enum PT_LabV2 = 30;
enum TYPE_GRAY_8 = COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(1);
enum TYPE_GRAY_8_REV = COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(1) | FLAVOR_SH(1);
enum TYPE_GRAY_16 = COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(2);
enum TYPE_GRAY_16_REV = COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(2) | FLAVOR_SH(1);
enum TYPE_GRAY_16_SE = COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_GRAYA_8 = COLORSPACE_SH(PT_GRAY) | EXTRA_SH(1) | CHANNELS_SH(1) | BYTES_SH(1);
enum TYPE_GRAYA_8_PREMUL = COLORSPACE_SH(PT_GRAY) | EXTRA_SH(1) | CHANNELS_SH(1) | BYTES_SH(1) | PREMUL_SH(1);
enum TYPE_GRAYA_16 = COLORSPACE_SH(PT_GRAY) | EXTRA_SH(1) | CHANNELS_SH(1) | BYTES_SH(2);
enum TYPE_GRAYA_16_PREMUL = COLORSPACE_SH(PT_GRAY) | EXTRA_SH(1) | CHANNELS_SH(1) | BYTES_SH(2) | PREMUL_SH(1);
enum TYPE_GRAYA_16_SE = COLORSPACE_SH(PT_GRAY) | EXTRA_SH(1) | CHANNELS_SH(1) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_GRAYA_8_PLANAR = COLORSPACE_SH(PT_GRAY) | EXTRA_SH(1) | CHANNELS_SH(1) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_GRAYA_16_PLANAR = COLORSPACE_SH(PT_GRAY) | EXTRA_SH(1) | CHANNELS_SH(1) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_RGB_8 = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_RGB_8_PLANAR = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_BGR_8 = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_BGR_8_PLANAR = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(1) | DOSWAP_SH(1) | PLANAR_SH(1);
enum TYPE_RGB_16 = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_RGB_16_PLANAR = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_RGB_16_SE = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_BGR_16 = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_BGR_16_PLANAR = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1) | PLANAR_SH(1);
enum TYPE_BGR_16_SE = COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_RGBA_8 = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_RGBA_8_PREMUL = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | PREMUL_SH(1);
enum TYPE_RGBA_8_PLANAR = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_RGBA_16 = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_RGBA_16_PREMUL = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | PREMUL_SH(1);
enum TYPE_RGBA_16_PLANAR = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_RGBA_16_SE = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_ARGB_8 = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | SWAPFIRST_SH(1);
enum TYPE_ARGB_8_PREMUL = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | SWAPFIRST_SH(1) | PREMUL_SH(1);
enum TYPE_ARGB_8_PLANAR = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | SWAPFIRST_SH(1) | PLANAR_SH(1);
enum TYPE_ARGB_16 = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | SWAPFIRST_SH(1);
enum TYPE_ARGB_16_PREMUL = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | SWAPFIRST_SH(1) | PREMUL_SH(1);
enum TYPE_ABGR_8 = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_ABGR_8_PREMUL = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | DOSWAP_SH(1) | PREMUL_SH(1);
enum TYPE_ABGR_8_PLANAR = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | DOSWAP_SH(1) | PLANAR_SH(1);
enum TYPE_ABGR_16 = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_ABGR_16_PREMUL = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1) | PREMUL_SH(1);
enum TYPE_ABGR_16_PLANAR = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1) | PLANAR_SH(1);
enum TYPE_ABGR_16_SE = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_BGRA_8 = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | DOSWAP_SH(1) | SWAPFIRST_SH(1);
enum TYPE_BGRA_8_PREMUL = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | DOSWAP_SH(1) | SWAPFIRST_SH(1) | PREMUL_SH(1);
enum TYPE_BGRA_8_PLANAR = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(1) | DOSWAP_SH(1) | SWAPFIRST_SH(1) | PLANAR_SH(1);
enum TYPE_BGRA_16 = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1) | SWAPFIRST_SH(1);
enum TYPE_BGRA_16_PREMUL = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1) | SWAPFIRST_SH(1) | PREMUL_SH(1);
enum TYPE_BGRA_16_SE = COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | ENDIAN16_SH(1) | DOSWAP_SH(1) | SWAPFIRST_SH(1);
enum TYPE_CMY_8 = COLORSPACE_SH(PT_CMY) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_CMY_8_PLANAR = COLORSPACE_SH(PT_CMY) | CHANNELS_SH(3) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_CMY_16 = COLORSPACE_SH(PT_CMY) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_CMY_16_PLANAR = COLORSPACE_SH(PT_CMY) | CHANNELS_SH(3) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_CMY_16_SE = COLORSPACE_SH(PT_CMY) | CHANNELS_SH(3) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_CMYK_8 = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(1);
enum TYPE_CMYKA_8 = COLORSPACE_SH(PT_CMYK) | EXTRA_SH(1) | CHANNELS_SH(4) | BYTES_SH(1);
enum TYPE_CMYK_8_REV = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(1) | FLAVOR_SH(1);
enum TYPE_YUVK_8 = TYPE_CMYK_8_REV;
enum TYPE_CMYK_8_PLANAR = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_CMYK_16 = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2);
enum TYPE_CMYK_16_REV = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2) | FLAVOR_SH(1);
enum TYPE_YUVK_16 = TYPE_CMYK_16_REV;
enum TYPE_CMYK_16_PLANAR = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_CMYK_16_SE = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_KYMC_8 = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_KYMC_16 = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_KYMC_16_SE = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_KCMY_8 = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(1) | SWAPFIRST_SH(1);
enum TYPE_KCMY_8_REV = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(1) | FLAVOR_SH(1) | SWAPFIRST_SH(1);
enum TYPE_KCMY_16 = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2) | SWAPFIRST_SH(1);
enum TYPE_KCMY_16_REV = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2) | FLAVOR_SH(1) | SWAPFIRST_SH(1);
enum TYPE_KCMY_16_SE = COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2) | ENDIAN16_SH(1) | SWAPFIRST_SH(1);
enum TYPE_CMYK5_8 = COLORSPACE_SH(PT_MCH5) | CHANNELS_SH(5) | BYTES_SH(1);
enum TYPE_CMYK5_16 = COLORSPACE_SH(PT_MCH5) | CHANNELS_SH(5) | BYTES_SH(2);
enum TYPE_CMYK5_16_SE = COLORSPACE_SH(PT_MCH5) | CHANNELS_SH(5) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_KYMC5_8 = COLORSPACE_SH(PT_MCH5) | CHANNELS_SH(5) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_KYMC5_16 = COLORSPACE_SH(PT_MCH5) | CHANNELS_SH(5) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_KYMC5_16_SE = COLORSPACE_SH(PT_MCH5) | CHANNELS_SH(5) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_CMYK6_8 = COLORSPACE_SH(PT_MCH6) | CHANNELS_SH(6) | BYTES_SH(1);
enum TYPE_CMYK6_8_PLANAR = COLORSPACE_SH(PT_MCH6) | CHANNELS_SH(6) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_CMYK6_16 = COLORSPACE_SH(PT_MCH6) | CHANNELS_SH(6) | BYTES_SH(2);
enum TYPE_CMYK6_16_PLANAR = COLORSPACE_SH(PT_MCH6) | CHANNELS_SH(6) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_CMYK6_16_SE = COLORSPACE_SH(PT_MCH6) | CHANNELS_SH(6) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_CMYK7_8 = COLORSPACE_SH(PT_MCH7) | CHANNELS_SH(7) | BYTES_SH(1);
enum TYPE_CMYK7_16 = COLORSPACE_SH(PT_MCH7) | CHANNELS_SH(7) | BYTES_SH(2);
enum TYPE_CMYK7_16_SE = COLORSPACE_SH(PT_MCH7) | CHANNELS_SH(7) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_KYMC7_8 = COLORSPACE_SH(PT_MCH7) | CHANNELS_SH(7) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_KYMC7_16 = COLORSPACE_SH(PT_MCH7) | CHANNELS_SH(7) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_KYMC7_16_SE = COLORSPACE_SH(PT_MCH7) | CHANNELS_SH(7) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_CMYK8_8 = COLORSPACE_SH(PT_MCH8) | CHANNELS_SH(8) | BYTES_SH(1);
enum TYPE_CMYK8_16 = COLORSPACE_SH(PT_MCH8) | CHANNELS_SH(8) | BYTES_SH(2);
enum TYPE_CMYK8_16_SE = COLORSPACE_SH(PT_MCH8) | CHANNELS_SH(8) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_KYMC8_8 = COLORSPACE_SH(PT_MCH8) | CHANNELS_SH(8) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_KYMC8_16 = COLORSPACE_SH(PT_MCH8) | CHANNELS_SH(8) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_KYMC8_16_SE = COLORSPACE_SH(PT_MCH8) | CHANNELS_SH(8) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_CMYK9_8 = COLORSPACE_SH(PT_MCH9) | CHANNELS_SH(9) | BYTES_SH(1);
enum TYPE_CMYK9_16 = COLORSPACE_SH(PT_MCH9) | CHANNELS_SH(9) | BYTES_SH(2);
enum TYPE_CMYK9_16_SE = COLORSPACE_SH(PT_MCH9) | CHANNELS_SH(9) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_KYMC9_8 = COLORSPACE_SH(PT_MCH9) | CHANNELS_SH(9) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_KYMC9_16 = COLORSPACE_SH(PT_MCH9) | CHANNELS_SH(9) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_KYMC9_16_SE = COLORSPACE_SH(PT_MCH9) | CHANNELS_SH(9) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_CMYK10_8 = COLORSPACE_SH(PT_MCH10) | CHANNELS_SH(10) | BYTES_SH(1);
enum TYPE_CMYK10_16 = COLORSPACE_SH(PT_MCH10) | CHANNELS_SH(10) | BYTES_SH(2);
enum TYPE_CMYK10_16_SE = COLORSPACE_SH(PT_MCH10) | CHANNELS_SH(10) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_KYMC10_8 = COLORSPACE_SH(PT_MCH10) | CHANNELS_SH(10) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_KYMC10_16 = COLORSPACE_SH(PT_MCH10) | CHANNELS_SH(10) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_KYMC10_16_SE = COLORSPACE_SH(PT_MCH10) | CHANNELS_SH(10) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_CMYK11_8 = COLORSPACE_SH(PT_MCH11) | CHANNELS_SH(11) | BYTES_SH(1);
enum TYPE_CMYK11_16 = COLORSPACE_SH(PT_MCH11) | CHANNELS_SH(11) | BYTES_SH(2);
enum TYPE_CMYK11_16_SE = COLORSPACE_SH(PT_MCH11) | CHANNELS_SH(11) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_KYMC11_8 = COLORSPACE_SH(PT_MCH11) | CHANNELS_SH(11) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_KYMC11_16 = COLORSPACE_SH(PT_MCH11) | CHANNELS_SH(11) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_KYMC11_16_SE = COLORSPACE_SH(PT_MCH11) | CHANNELS_SH(11) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_CMYK12_8 = COLORSPACE_SH(PT_MCH12) | CHANNELS_SH(12) | BYTES_SH(1);
enum TYPE_CMYK12_16 = COLORSPACE_SH(PT_MCH12) | CHANNELS_SH(12) | BYTES_SH(2);
enum TYPE_CMYK12_16_SE = COLORSPACE_SH(PT_MCH12) | CHANNELS_SH(12) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_KYMC12_8 = COLORSPACE_SH(PT_MCH12) | CHANNELS_SH(12) | BYTES_SH(1) | DOSWAP_SH(1);
enum TYPE_KYMC12_16 = COLORSPACE_SH(PT_MCH12) | CHANNELS_SH(12) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_KYMC12_16_SE = COLORSPACE_SH(PT_MCH12) | CHANNELS_SH(12) | BYTES_SH(2) | DOSWAP_SH(1) | ENDIAN16_SH(1);
enum TYPE_XYZ_16 = COLORSPACE_SH(PT_XYZ) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_Lab_8 = COLORSPACE_SH(PT_Lab) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_LabV2_8 = COLORSPACE_SH(PT_LabV2) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_ALab_8 = COLORSPACE_SH(PT_Lab) | CHANNELS_SH(3) | BYTES_SH(1) | EXTRA_SH(1) | SWAPFIRST_SH(1);
enum TYPE_ALabV2_8 = COLORSPACE_SH(PT_LabV2) | CHANNELS_SH(3) | BYTES_SH(1) | EXTRA_SH(1) | SWAPFIRST_SH(1);
enum TYPE_Lab_16 = COLORSPACE_SH(PT_Lab) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_LabV2_16 = COLORSPACE_SH(PT_LabV2) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_Yxy_16 = COLORSPACE_SH(PT_Yxy) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_YCbCr_8 = COLORSPACE_SH(PT_YCbCr) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_YCbCr_8_PLANAR = COLORSPACE_SH(PT_YCbCr) | CHANNELS_SH(3) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_YCbCr_16 = COLORSPACE_SH(PT_YCbCr) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_YCbCr_16_PLANAR = COLORSPACE_SH(PT_YCbCr) | CHANNELS_SH(3) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_YCbCr_16_SE = COLORSPACE_SH(PT_YCbCr) | CHANNELS_SH(3) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_YUV_8 = COLORSPACE_SH(PT_YUV) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_YUV_8_PLANAR = COLORSPACE_SH(PT_YUV) | CHANNELS_SH(3) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_YUV_16 = COLORSPACE_SH(PT_YUV) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_YUV_16_PLANAR = COLORSPACE_SH(PT_YUV) | CHANNELS_SH(3) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_YUV_16_SE = COLORSPACE_SH(PT_YUV) | CHANNELS_SH(3) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_HLS_8 = COLORSPACE_SH(PT_HLS) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_HLS_8_PLANAR = COLORSPACE_SH(PT_HLS) | CHANNELS_SH(3) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_HLS_16 = COLORSPACE_SH(PT_HLS) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_HLS_16_PLANAR = COLORSPACE_SH(PT_HLS) | CHANNELS_SH(3) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_HLS_16_SE = COLORSPACE_SH(PT_HLS) | CHANNELS_SH(3) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_HSV_8 = COLORSPACE_SH(PT_HSV) | CHANNELS_SH(3) | BYTES_SH(1);
enum TYPE_HSV_8_PLANAR = COLORSPACE_SH(PT_HSV) | CHANNELS_SH(3) | BYTES_SH(1) | PLANAR_SH(1);
enum TYPE_HSV_16 = COLORSPACE_SH(PT_HSV) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_HSV_16_PLANAR = COLORSPACE_SH(PT_HSV) | CHANNELS_SH(3) | BYTES_SH(2) | PLANAR_SH(1);
enum TYPE_HSV_16_SE = COLORSPACE_SH(PT_HSV) | CHANNELS_SH(3) | BYTES_SH(2) | ENDIAN16_SH(1);
enum TYPE_NAMED_COLOR_INDEX = CHANNELS_SH(1) | BYTES_SH(2);
enum TYPE_XYZ_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_XYZ) | CHANNELS_SH(3) | BYTES_SH(4);
enum TYPE_Lab_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_Lab) | CHANNELS_SH(3) | BYTES_SH(4);
enum TYPE_LabA_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_Lab) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4);
enum TYPE_GRAY_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(4);
enum TYPE_GRAYA_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(4) | EXTRA_SH(1);
enum TYPE_GRAYA_FLT_PREMUL = FLOAT_SH(1) | COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(4) | EXTRA_SH(1) | PREMUL_SH(1);
enum TYPE_RGB_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(4);
enum TYPE_RGBA_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4);
enum TYPE_RGBA_FLT_PREMUL = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4) | PREMUL_SH(1);
enum TYPE_ARGB_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4) | SWAPFIRST_SH(1);
enum TYPE_ARGB_FLT_PREMUL = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4) | SWAPFIRST_SH(1) | PREMUL_SH(1);
enum TYPE_BGR_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(4) | DOSWAP_SH(1);
enum TYPE_BGRA_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4) | DOSWAP_SH(1) | SWAPFIRST_SH(1);
enum TYPE_BGRA_FLT_PREMUL = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4) | DOSWAP_SH(1) | SWAPFIRST_SH(1) | PREMUL_SH(1);
enum TYPE_ABGR_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4) | DOSWAP_SH(1);
enum TYPE_ABGR_FLT_PREMUL = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(4) | DOSWAP_SH(1) | PREMUL_SH(1);
enum TYPE_CMYK_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(4);
enum TYPE_XYZ_DBL = FLOAT_SH(1) | COLORSPACE_SH(PT_XYZ) | CHANNELS_SH(3) | BYTES_SH(0);
enum TYPE_Lab_DBL = FLOAT_SH(1) | COLORSPACE_SH(PT_Lab) | CHANNELS_SH(3) | BYTES_SH(0);
enum TYPE_GRAY_DBL = FLOAT_SH(1) | COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(0);
enum TYPE_RGB_DBL = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(0);
enum TYPE_BGR_DBL = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(0) | DOSWAP_SH(1);
enum TYPE_CMYK_DBL = FLOAT_SH(1) | COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(0);
enum TYPE_GRAY_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_GRAY) | CHANNELS_SH(1) | BYTES_SH(2);
enum TYPE_RGB_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_RGBA_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_CMYK_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_CMYK) | CHANNELS_SH(4) | BYTES_SH(2);
//enum TYPE_RGBA_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2);
enum TYPE_ARGB_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | SWAPFIRST_SH(1);
enum TYPE_BGR_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1);
enum TYPE_BGRA_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | EXTRA_SH(1) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1) | SWAPFIRST_SH(1);
enum TYPE_ABGR_HALF_FLT = FLOAT_SH(1) | COLORSPACE_SH(PT_RGB) | CHANNELS_SH(3) | BYTES_SH(2) | DOSWAP_SH(1);
enum cmsILLUMINANT_TYPE_UNKNOWN = 0x0000000;
enum cmsILLUMINANT_TYPE_D50 = 0x0000001;
enum cmsILLUMINANT_TYPE_D65 = 0x0000002;
enum cmsILLUMINANT_TYPE_D93 = 0x0000003;
enum cmsILLUMINANT_TYPE_F2 = 0x0000004;
enum cmsILLUMINANT_TYPE_D55 = 0x0000005;
enum cmsILLUMINANT_TYPE_A = 0x0000006;
enum cmsILLUMINANT_TYPE_E = 0x0000007;
enum cmsILLUMINANT_TYPE_F8 = 0x0000008;
enum cmsERROR_UNDEFINED = 0;
enum cmsERROR_FILE = 1;
enum cmsERROR_RANGE = 2;
enum cmsERROR_INTERNAL = 3;
enum cmsERROR_NULL = 4;
enum cmsERROR_READ = 5;
enum cmsERROR_SEEK = 6;
enum cmsERROR_WRITE = 7;
enum cmsERROR_UNKNOWN_EXTENSION = 8;
enum cmsERROR_COLORSPACE_CHECK = 9;
enum cmsERROR_ALREADY_DEFINED = 10;
enum cmsERROR_BAD_SIGNATURE = 11;
enum cmsERROR_CORRUPTION_DETECTED = 12;
enum cmsERROR_NOT_SUITABLE = 13;
enum AVG_SURROUND = 1;
enum DIM_SURROUND = 2;
enum DARK_SURROUND = 3;
enum CUTSHEET_SURROUND = 4;
enum D_CALCULATE = -1;
enum SAMPLER_INSPECT = 0x01000000;
enum cmsNoLanguage = "\0\0";
enum cmsNoCountry = "\0\0";
enum cmsPRINTER_DEFAULT_SCREENS = 0x0001;
enum cmsFREQUENCE_UNITS_LINES_CM = 0x0000;
enum cmsFREQUENCE_UNITS_LINES_INCH = 0x0002;
enum cmsSPOT_UNKNOWN = 0;
enum cmsSPOT_PRINTER_DEFAULT = 1;
enum cmsSPOT_ROUND = 2;
enum cmsSPOT_DIAMOND = 3;
enum cmsSPOT_ELLIPSE = 4;
enum cmsSPOT_LINE = 5;
enum cmsSPOT_SQUARE = 6;
enum cmsSPOT_CROSS = 7;
enum cmsEmbeddedProfileFalse = 0x00000000;
enum cmsEmbeddedProfileTrue = 0x00000001;
enum cmsUseAnywhere = 0x00000000;
enum cmsUseWithEmbeddedDataOnly = 0x00000002;
enum LCMS_USED_AS_INPUT = 0;
enum LCMS_USED_AS_OUTPUT = 1;
enum LCMS_USED_AS_PROOF = 2;
enum INTENT_PERCEPTUAL = 0;
enum INTENT_RELATIVE_COLORIMETRIC = 1;
enum INTENT_SATURATION = 2;
enum INTENT_ABSOLUTE_COLORIMETRIC = 3;
enum INTENT_PRESERVE_K_ONLY_PERCEPTUAL = 10;
enum INTENT_PRESERVE_K_ONLY_RELATIVE_COLORIMETRIC = 11;
enum INTENT_PRESERVE_K_ONLY_SATURATION = 12;
enum INTENT_PRESERVE_K_PLANE_PERCEPTUAL = 13;
enum INTENT_PRESERVE_K_PLANE_RELATIVE_COLORIMETRIC = 14;
enum INTENT_PRESERVE_K_PLANE_SATURATION = 15;
enum cmsFLAGS_NOCACHE = 0x0040;
enum cmsFLAGS_NOOPTIMIZE = 0x0100;
enum cmsFLAGS_NULLTRANSFORM = 0x0200;
enum cmsFLAGS_GAMUTCHECK = 0x1000;
enum cmsFLAGS_SOFTPROOFING = 0x4000;
enum cmsFLAGS_BLACKPOINTCOMPENSATION = 0x2000;
enum cmsFLAGS_NOWHITEONWHITEFIXUP = 0x0004;
enum cmsFLAGS_HIGHRESPRECALC = 0x0400;
enum cmsFLAGS_LOWRESPRECALC = 0x0800;
enum cmsFLAGS_8BITS_DEVICELINK = 0x0008;
enum cmsFLAGS_GUESSDEVICECLASS = 0x0020;
enum cmsFLAGS_KEEP_SEQUENCE = 0x0080;
enum cmsFLAGS_FORCE_CLUT = 0x0002;
enum cmsFLAGS_CLUT_POST_LINEARIZATION = 0x0001;
enum cmsFLAGS_CLUT_PRE_LINEARIZATION = 0x0010;
enum cmsFLAGS_NONEGATIVES = 0x8000;
enum cmsFLAGS_COPY_ALPHA = 0x04000000;

extern (D) auto cmsFLAGS_GRIDPOINTS(T)(auto ref T n)
{
    return (n & 0xFF) << 16;
}

enum cmsFLAGS_NODEFAULTRESOURCEDEF = 0x01000000;

