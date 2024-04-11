# nim c -r -d:release --threads:on  ex04_transpose.nim | ffplay -i pipe:
# nim c -r ex04_transpose.nim | ffplay -i pipe:
import vs
source("2sec.mkv").transpose.pipeY4M
