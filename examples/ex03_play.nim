# nim c -r -d:release --threads:on  ex03_play.nim | ffplay -i pipe:
# nim c -r ex03_play.nim | ffplay -i pipe:
import vs
source("../media/2sec.mkv").pipeY4M