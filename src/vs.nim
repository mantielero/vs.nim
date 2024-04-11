{.passL:"-lvapoursynth".}

import lib/[consts, libapi, libcore, helper, libvsplugins, libvsmap, info, libvsnode] # libvsanode,
export consts, libapi, libcore, helper, libvsplugins, libvsmap, libvsnode, info

import plugins4/all_plugins
export all_plugins

import lib/audio/[audioformat, audioinfo]
export audioformat, audioinfo

import lib/output/output
export output