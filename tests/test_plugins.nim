import vs

# Plugins
for i in plugins():
  echo "PLUGIN: "
  echo "  path: ", i.path
  echo "  version: ", i.version
  echo "  name: ", i.name
  echo "  id: ", i.id
  echo "  namespace: ", i.namespace
  for f in i.functions():
    echo "    FUNCTION"
    echo "       name:", f.name
    echo "       arguments:"
    for arg in f.args:
      echo "         ", arg
    echo "       return: ", f.ret

var plugin = getPluginById("com.vapoursynth.text")
echo plugin.name

var plugin2 = getPluginByNamespace("std")
echo plugin2.name

var function = plugin2.getFunctionByName("Turn180")
echo function.name

for f in plugin2.functions():
  if f.name == "BlankAudio":
    for arg in f.args:
      echo arg