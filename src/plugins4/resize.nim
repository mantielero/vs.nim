import options
import ../lib/vsmap/libvsmap
import ../lib/node/libvsnode
import ../lib/frame/libvsframe
import ../lib/function/libvsfunction
import ../lib/plugin/libvsplugins
import ../lib/api/libapi

proc bicubic*(vsmap:VSMapRef;
              width= none(int);
              height= none(int);
              format= none(int);
              matrix= none(int);
              matrix_s= none(string);
              transfer= none(int);
              transfer_s= none(string);
              primaries= none(int);
              primaries_s= none(string);
              range= none(int);
              range_s= none(string);
              chromaloc= none(int);
              chromaloc_s= none(string);
              matrix_in= none(int);
              matrix_in_s= none(string);
              transfer_in= none(int);
              transfer_in_s= none(string);
              primaries_in= none(int);
              primaries_in_s= none(string);
              range_in= none(int);
              range_in_s= none(string);
              chromaloc_in= none(int);
              chromaloc_in_s= none(string);
              filter_param_a= none(float);
              filter_param_b= none(float);
              resample_filter_uv= none(string);
              filter_param_a_uv= none(float);
              filter_param_b_uv= none(float);
              dither_type= none(string);
              cpu_type= none(string);
              prefer_props= none(int);
              src_left= none(float);
              src_top= none(float);
              src_width= none(float);
              src_height= none(float);
              nominal_luminance= none(float);
              approximate_gamma= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.resize")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.resize\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if format.isSome: args.set("format", format.get)
  if matrix.isSome: args.set("matrix", matrix.get)
  if matrix_s.isSome: args.set("matrix_s", matrix_s.get)
  if transfer.isSome: args.set("transfer", transfer.get)
  if transfer_s.isSome: args.set("transfer_s", transfer_s.get)
  if primaries.isSome: args.set("primaries", primaries.get)
  if primaries_s.isSome: args.set("primaries_s", primaries_s.get)
  if range.isSome: args.set("range", range.get)
  if range_s.isSome: args.set("range_s", range_s.get)
  if chromaloc.isSome: args.set("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.set("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.set("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.set("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.set("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.set("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.set("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.set("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.set("range_in", range_in.get)
  if range_in_s.isSome: args.set("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.set("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.set("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.set("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.set("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.set("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.set("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.set("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.set("dither_type", dither_type.get)
  if cpu_type.isSome: args.set("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.set("prefer_props", prefer_props.get)
  if src_left.isSome: args.set("src_left", src_left.get)
  if src_top.isSome: args.set("src_top", src_top.get)
  if src_width.isSome: args.set("src_width", src_width.get)
  if src_height.isSome: args.set("src_height", src_height.get)
  if nominal_luminance.isSome: args.set("nominal_luminance", nominal_luminance.get)
  if approximate_gamma.isSome: args.set("approximate_gamma", approximate_gamma.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Bicubic".cstring, args.handle)


proc bilinear*(vsmap:VSMapRef;
               width= none(int);
               height= none(int);
               format= none(int);
               matrix= none(int);
               matrix_s= none(string);
               transfer= none(int);
               transfer_s= none(string);
               primaries= none(int);
               primaries_s= none(string);
               range= none(int);
               range_s= none(string);
               chromaloc= none(int);
               chromaloc_s= none(string);
               matrix_in= none(int);
               matrix_in_s= none(string);
               transfer_in= none(int);
               transfer_in_s= none(string);
               primaries_in= none(int);
               primaries_in_s= none(string);
               range_in= none(int);
               range_in_s= none(string);
               chromaloc_in= none(int);
               chromaloc_in_s= none(string);
               filter_param_a= none(float);
               filter_param_b= none(float);
               resample_filter_uv= none(string);
               filter_param_a_uv= none(float);
               filter_param_b_uv= none(float);
               dither_type= none(string);
               cpu_type= none(string);
               prefer_props= none(int);
               src_left= none(float);
               src_top= none(float);
               src_width= none(float);
               src_height= none(float);
               nominal_luminance= none(float);
               approximate_gamma= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.resize")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.resize\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if format.isSome: args.set("format", format.get)
  if matrix.isSome: args.set("matrix", matrix.get)
  if matrix_s.isSome: args.set("matrix_s", matrix_s.get)
  if transfer.isSome: args.set("transfer", transfer.get)
  if transfer_s.isSome: args.set("transfer_s", transfer_s.get)
  if primaries.isSome: args.set("primaries", primaries.get)
  if primaries_s.isSome: args.set("primaries_s", primaries_s.get)
  if range.isSome: args.set("range", range.get)
  if range_s.isSome: args.set("range_s", range_s.get)
  if chromaloc.isSome: args.set("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.set("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.set("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.set("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.set("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.set("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.set("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.set("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.set("range_in", range_in.get)
  if range_in_s.isSome: args.set("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.set("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.set("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.set("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.set("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.set("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.set("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.set("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.set("dither_type", dither_type.get)
  if cpu_type.isSome: args.set("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.set("prefer_props", prefer_props.get)
  if src_left.isSome: args.set("src_left", src_left.get)
  if src_top.isSome: args.set("src_top", src_top.get)
  if src_width.isSome: args.set("src_width", src_width.get)
  if src_height.isSome: args.set("src_height", src_height.get)
  if nominal_luminance.isSome: args.set("nominal_luminance", nominal_luminance.get)
  if approximate_gamma.isSome: args.set("approximate_gamma", approximate_gamma.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Bilinear".cstring, args.handle)


proc bob*(vsmap:VSMapRef;
          filter= none(string);
          tff= none(int);
          format= none(int);
          matrix= none(int);
          matrix_s= none(string);
          transfer= none(int);
          transfer_s= none(string);
          primaries= none(int);
          primaries_s= none(string);
          range= none(int);
          range_s= none(string);
          chromaloc= none(int);
          chromaloc_s= none(string);
          matrix_in= none(int);
          matrix_in_s= none(string);
          transfer_in= none(int);
          transfer_in_s= none(string);
          primaries_in= none(int);
          primaries_in_s= none(string);
          range_in= none(int);
          range_in_s= none(string);
          chromaloc_in= none(int);
          chromaloc_in_s= none(string);
          filter_param_a= none(float);
          filter_param_b= none(float);
          resample_filter_uv= none(string);
          filter_param_a_uv= none(float);
          filter_param_b_uv= none(float);
          dither_type= none(string);
          cpu_type= none(string);
          prefer_props= none(int);
          src_left= none(float);
          src_top= none(float);
          src_width= none(float);
          src_height= none(float);
          nominal_luminance= none(float);
          approximate_gamma= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.resize")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.resize\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if filter.isSome: args.set("filter", filter.get)
  if tff.isSome: args.set("tff", tff.get)
  if format.isSome: args.set("format", format.get)
  if matrix.isSome: args.set("matrix", matrix.get)
  if matrix_s.isSome: args.set("matrix_s", matrix_s.get)
  if transfer.isSome: args.set("transfer", transfer.get)
  if transfer_s.isSome: args.set("transfer_s", transfer_s.get)
  if primaries.isSome: args.set("primaries", primaries.get)
  if primaries_s.isSome: args.set("primaries_s", primaries_s.get)
  if range.isSome: args.set("range", range.get)
  if range_s.isSome: args.set("range_s", range_s.get)
  if chromaloc.isSome: args.set("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.set("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.set("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.set("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.set("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.set("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.set("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.set("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.set("range_in", range_in.get)
  if range_in_s.isSome: args.set("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.set("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.set("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.set("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.set("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.set("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.set("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.set("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.set("dither_type", dither_type.get)
  if cpu_type.isSome: args.set("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.set("prefer_props", prefer_props.get)
  if src_left.isSome: args.set("src_left", src_left.get)
  if src_top.isSome: args.set("src_top", src_top.get)
  if src_width.isSome: args.set("src_width", src_width.get)
  if src_height.isSome: args.set("src_height", src_height.get)
  if nominal_luminance.isSome: args.set("nominal_luminance", nominal_luminance.get)
  if approximate_gamma.isSome: args.set("approximate_gamma", approximate_gamma.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Bob".cstring, args.handle)


proc lanczos*(vsmap:VSMapRef;
              width= none(int);
              height= none(int);
              format= none(int);
              matrix= none(int);
              matrix_s= none(string);
              transfer= none(int);
              transfer_s= none(string);
              primaries= none(int);
              primaries_s= none(string);
              range= none(int);
              range_s= none(string);
              chromaloc= none(int);
              chromaloc_s= none(string);
              matrix_in= none(int);
              matrix_in_s= none(string);
              transfer_in= none(int);
              transfer_in_s= none(string);
              primaries_in= none(int);
              primaries_in_s= none(string);
              range_in= none(int);
              range_in_s= none(string);
              chromaloc_in= none(int);
              chromaloc_in_s= none(string);
              filter_param_a= none(float);
              filter_param_b= none(float);
              resample_filter_uv= none(string);
              filter_param_a_uv= none(float);
              filter_param_b_uv= none(float);
              dither_type= none(string);
              cpu_type= none(string);
              prefer_props= none(int);
              src_left= none(float);
              src_top= none(float);
              src_width= none(float);
              src_height= none(float);
              nominal_luminance= none(float);
              approximate_gamma= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.resize")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.resize\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if format.isSome: args.set("format", format.get)
  if matrix.isSome: args.set("matrix", matrix.get)
  if matrix_s.isSome: args.set("matrix_s", matrix_s.get)
  if transfer.isSome: args.set("transfer", transfer.get)
  if transfer_s.isSome: args.set("transfer_s", transfer_s.get)
  if primaries.isSome: args.set("primaries", primaries.get)
  if primaries_s.isSome: args.set("primaries_s", primaries_s.get)
  if range.isSome: args.set("range", range.get)
  if range_s.isSome: args.set("range_s", range_s.get)
  if chromaloc.isSome: args.set("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.set("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.set("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.set("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.set("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.set("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.set("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.set("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.set("range_in", range_in.get)
  if range_in_s.isSome: args.set("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.set("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.set("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.set("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.set("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.set("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.set("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.set("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.set("dither_type", dither_type.get)
  if cpu_type.isSome: args.set("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.set("prefer_props", prefer_props.get)
  if src_left.isSome: args.set("src_left", src_left.get)
  if src_top.isSome: args.set("src_top", src_top.get)
  if src_width.isSome: args.set("src_width", src_width.get)
  if src_height.isSome: args.set("src_height", src_height.get)
  if nominal_luminance.isSome: args.set("nominal_luminance", nominal_luminance.get)
  if approximate_gamma.isSome: args.set("approximate_gamma", approximate_gamma.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Lanczos".cstring, args.handle)


proc point*(vsmap:VSMapRef;
            width= none(int);
            height= none(int);
            format= none(int);
            matrix= none(int);
            matrix_s= none(string);
            transfer= none(int);
            transfer_s= none(string);
            primaries= none(int);
            primaries_s= none(string);
            range= none(int);
            range_s= none(string);
            chromaloc= none(int);
            chromaloc_s= none(string);
            matrix_in= none(int);
            matrix_in_s= none(string);
            transfer_in= none(int);
            transfer_in_s= none(string);
            primaries_in= none(int);
            primaries_in_s= none(string);
            range_in= none(int);
            range_in_s= none(string);
            chromaloc_in= none(int);
            chromaloc_in_s= none(string);
            filter_param_a= none(float);
            filter_param_b= none(float);
            resample_filter_uv= none(string);
            filter_param_a_uv= none(float);
            filter_param_b_uv= none(float);
            dither_type= none(string);
            cpu_type= none(string);
            prefer_props= none(int);
            src_left= none(float);
            src_top= none(float);
            src_width= none(float);
            src_height= none(float);
            nominal_luminance= none(float);
            approximate_gamma= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.resize")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.resize\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if format.isSome: args.set("format", format.get)
  if matrix.isSome: args.set("matrix", matrix.get)
  if matrix_s.isSome: args.set("matrix_s", matrix_s.get)
  if transfer.isSome: args.set("transfer", transfer.get)
  if transfer_s.isSome: args.set("transfer_s", transfer_s.get)
  if primaries.isSome: args.set("primaries", primaries.get)
  if primaries_s.isSome: args.set("primaries_s", primaries_s.get)
  if range.isSome: args.set("range", range.get)
  if range_s.isSome: args.set("range_s", range_s.get)
  if chromaloc.isSome: args.set("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.set("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.set("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.set("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.set("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.set("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.set("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.set("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.set("range_in", range_in.get)
  if range_in_s.isSome: args.set("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.set("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.set("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.set("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.set("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.set("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.set("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.set("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.set("dither_type", dither_type.get)
  if cpu_type.isSome: args.set("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.set("prefer_props", prefer_props.get)
  if src_left.isSome: args.set("src_left", src_left.get)
  if src_top.isSome: args.set("src_top", src_top.get)
  if src_width.isSome: args.set("src_width", src_width.get)
  if src_height.isSome: args.set("src_height", src_height.get)
  if nominal_luminance.isSome: args.set("nominal_luminance", nominal_luminance.get)
  if approximate_gamma.isSome: args.set("approximate_gamma", approximate_gamma.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Point".cstring, args.handle)


proc spline16*(vsmap:VSMapRef;
               width= none(int);
               height= none(int);
               format= none(int);
               matrix= none(int);
               matrix_s= none(string);
               transfer= none(int);
               transfer_s= none(string);
               primaries= none(int);
               primaries_s= none(string);
               range= none(int);
               range_s= none(string);
               chromaloc= none(int);
               chromaloc_s= none(string);
               matrix_in= none(int);
               matrix_in_s= none(string);
               transfer_in= none(int);
               transfer_in_s= none(string);
               primaries_in= none(int);
               primaries_in_s= none(string);
               range_in= none(int);
               range_in_s= none(string);
               chromaloc_in= none(int);
               chromaloc_in_s= none(string);
               filter_param_a= none(float);
               filter_param_b= none(float);
               resample_filter_uv= none(string);
               filter_param_a_uv= none(float);
               filter_param_b_uv= none(float);
               dither_type= none(string);
               cpu_type= none(string);
               prefer_props= none(int);
               src_left= none(float);
               src_top= none(float);
               src_width= none(float);
               src_height= none(float);
               nominal_luminance= none(float);
               approximate_gamma= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.resize")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.resize\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if format.isSome: args.set("format", format.get)
  if matrix.isSome: args.set("matrix", matrix.get)
  if matrix_s.isSome: args.set("matrix_s", matrix_s.get)
  if transfer.isSome: args.set("transfer", transfer.get)
  if transfer_s.isSome: args.set("transfer_s", transfer_s.get)
  if primaries.isSome: args.set("primaries", primaries.get)
  if primaries_s.isSome: args.set("primaries_s", primaries_s.get)
  if range.isSome: args.set("range", range.get)
  if range_s.isSome: args.set("range_s", range_s.get)
  if chromaloc.isSome: args.set("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.set("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.set("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.set("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.set("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.set("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.set("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.set("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.set("range_in", range_in.get)
  if range_in_s.isSome: args.set("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.set("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.set("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.set("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.set("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.set("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.set("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.set("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.set("dither_type", dither_type.get)
  if cpu_type.isSome: args.set("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.set("prefer_props", prefer_props.get)
  if src_left.isSome: args.set("src_left", src_left.get)
  if src_top.isSome: args.set("src_top", src_top.get)
  if src_width.isSome: args.set("src_width", src_width.get)
  if src_height.isSome: args.set("src_height", src_height.get)
  if nominal_luminance.isSome: args.set("nominal_luminance", nominal_luminance.get)
  if approximate_gamma.isSome: args.set("approximate_gamma", approximate_gamma.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Spline16".cstring, args.handle)


proc spline36*(vsmap:VSMapRef;
               width= none(int);
               height= none(int);
               format= none(int);
               matrix= none(int);
               matrix_s= none(string);
               transfer= none(int);
               transfer_s= none(string);
               primaries= none(int);
               primaries_s= none(string);
               range= none(int);
               range_s= none(string);
               chromaloc= none(int);
               chromaloc_s= none(string);
               matrix_in= none(int);
               matrix_in_s= none(string);
               transfer_in= none(int);
               transfer_in_s= none(string);
               primaries_in= none(int);
               primaries_in_s= none(string);
               range_in= none(int);
               range_in_s= none(string);
               chromaloc_in= none(int);
               chromaloc_in_s= none(string);
               filter_param_a= none(float);
               filter_param_b= none(float);
               resample_filter_uv= none(string);
               filter_param_a_uv= none(float);
               filter_param_b_uv= none(float);
               dither_type= none(string);
               cpu_type= none(string);
               prefer_props= none(int);
               src_left= none(float);
               src_top= none(float);
               src_width= none(float);
               src_height= none(float);
               nominal_luminance= none(float);
               approximate_gamma= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.resize")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.resize\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if format.isSome: args.set("format", format.get)
  if matrix.isSome: args.set("matrix", matrix.get)
  if matrix_s.isSome: args.set("matrix_s", matrix_s.get)
  if transfer.isSome: args.set("transfer", transfer.get)
  if transfer_s.isSome: args.set("transfer_s", transfer_s.get)
  if primaries.isSome: args.set("primaries", primaries.get)
  if primaries_s.isSome: args.set("primaries_s", primaries_s.get)
  if range.isSome: args.set("range", range.get)
  if range_s.isSome: args.set("range_s", range_s.get)
  if chromaloc.isSome: args.set("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.set("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.set("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.set("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.set("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.set("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.set("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.set("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.set("range_in", range_in.get)
  if range_in_s.isSome: args.set("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.set("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.set("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.set("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.set("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.set("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.set("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.set("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.set("dither_type", dither_type.get)
  if cpu_type.isSome: args.set("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.set("prefer_props", prefer_props.get)
  if src_left.isSome: args.set("src_left", src_left.get)
  if src_top.isSome: args.set("src_top", src_top.get)
  if src_width.isSome: args.set("src_width", src_width.get)
  if src_height.isSome: args.set("src_height", src_height.get)
  if nominal_luminance.isSome: args.set("nominal_luminance", nominal_luminance.get)
  if approximate_gamma.isSome: args.set("approximate_gamma", approximate_gamma.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Spline36".cstring, args.handle)


proc spline64*(vsmap:VSMapRef;
               width= none(int);
               height= none(int);
               format= none(int);
               matrix= none(int);
               matrix_s= none(string);
               transfer= none(int);
               transfer_s= none(string);
               primaries= none(int);
               primaries_s= none(string);
               range= none(int);
               range_s= none(string);
               chromaloc= none(int);
               chromaloc_s= none(string);
               matrix_in= none(int);
               matrix_in_s= none(string);
               transfer_in= none(int);
               transfer_in_s= none(string);
               primaries_in= none(int);
               primaries_in_s= none(string);
               range_in= none(int);
               range_in_s= none(string);
               chromaloc_in= none(int);
               chromaloc_in_s= none(string);
               filter_param_a= none(float);
               filter_param_b= none(float);
               resample_filter_uv= none(string);
               filter_param_a_uv= none(float);
               filter_param_b_uv= none(float);
               dither_type= none(string);
               cpu_type= none(string);
               prefer_props= none(int);
               src_left= none(float);
               src_top= none(float);
               src_width= none(float);
               src_height= none(float);
               nominal_luminance= none(float);
               approximate_gamma= none(int)):VSMapRef =

  let plug = getPluginById("com.vapoursynth.resize")
  assert( plug.handle != nil, "plugin \"com.vapoursynth.resize\" not installed properly in your computer") 
  assert( vsmap.len != 0, "the vsmap should contain at least one item")
  assert( vsmap.len("clip") == 1, "the vsmap should contain one node")
  var clip = getFirstNode(vsmap)


  # Convert the function parameters into a VSMap (taking into account that some of them might be optional)
  let args = newMap()
  args.set("clip", clip)
  if width.isSome: args.set("width", width.get)
  if height.isSome: args.set("height", height.get)
  if format.isSome: args.set("format", format.get)
  if matrix.isSome: args.set("matrix", matrix.get)
  if matrix_s.isSome: args.set("matrix_s", matrix_s.get)
  if transfer.isSome: args.set("transfer", transfer.get)
  if transfer_s.isSome: args.set("transfer_s", transfer_s.get)
  if primaries.isSome: args.set("primaries", primaries.get)
  if primaries_s.isSome: args.set("primaries_s", primaries_s.get)
  if range.isSome: args.set("range", range.get)
  if range_s.isSome: args.set("range_s", range_s.get)
  if chromaloc.isSome: args.set("chromaloc", chromaloc.get)
  if chromaloc_s.isSome: args.set("chromaloc_s", chromaloc_s.get)
  if matrix_in.isSome: args.set("matrix_in", matrix_in.get)
  if matrix_in_s.isSome: args.set("matrix_in_s", matrix_in_s.get)
  if transfer_in.isSome: args.set("transfer_in", transfer_in.get)
  if transfer_in_s.isSome: args.set("transfer_in_s", transfer_in_s.get)
  if primaries_in.isSome: args.set("primaries_in", primaries_in.get)
  if primaries_in_s.isSome: args.set("primaries_in_s", primaries_in_s.get)
  if range_in.isSome: args.set("range_in", range_in.get)
  if range_in_s.isSome: args.set("range_in_s", range_in_s.get)
  if chromaloc_in.isSome: args.set("chromaloc_in", chromaloc_in.get)
  if chromaloc_in_s.isSome: args.set("chromaloc_in_s", chromaloc_in_s.get)
  if filter_param_a.isSome: args.set("filter_param_a", filter_param_a.get)
  if filter_param_b.isSome: args.set("filter_param_b", filter_param_b.get)
  if resample_filter_uv.isSome: args.set("resample_filter_uv", resample_filter_uv.get)
  if filter_param_a_uv.isSome: args.set("filter_param_a_uv", filter_param_a_uv.get)
  if filter_param_b_uv.isSome: args.set("filter_param_b_uv", filter_param_b_uv.get)
  if dither_type.isSome: args.set("dither_type", dither_type.get)
  if cpu_type.isSome: args.set("cpu_type", cpu_type.get)
  if prefer_props.isSome: args.set("prefer_props", prefer_props.get)
  if src_left.isSome: args.set("src_left", src_left.get)
  if src_top.isSome: args.set("src_top", src_top.get)
  if src_width.isSome: args.set("src_width", src_width.get)
  if src_height.isSome: args.set("src_height", src_height.get)
  if nominal_luminance.isSome: args.set("nominal_luminance", nominal_luminance.get)
  if approximate_gamma.isSome: args.set("approximate_gamma", approximate_gamma.get)

  result = newMap()
  result.handle = api.handle.invoke(plug.handle, "Spline64".cstring, args.handle)


