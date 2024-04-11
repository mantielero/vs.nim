# nim c -r -d:release --threads:on  ex04_transpose.nim | ffplay -i pipe:
import vs
ffms2.source("2sec.mkv").transpose.pipeY4M
