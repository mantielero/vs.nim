# nim c -r -d:release --threads:on  ex03_play.nim | ffplay -i pipe:
import vs
ffms2.source("2sec.mkv").pipeY4M