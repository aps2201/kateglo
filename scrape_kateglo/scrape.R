library(dplyr)
library(readr)
library(rvest)
ls_html = lapply(
  1:1446,function(x) {
    l = read_html(paste0("http://kateglo.com/?&op=1&phrase=&lex=&type=&src=&mod=dictionary&srch=Cari&p=",x))
    Sys.sleep(5)
    l
  }
)

a = lapply(1:1446, function(x) {
  html_nodes(ls_html[[x]],"dt") %>% 
    html_text()
}
)
b = lapply(1:1446, function(x) {
  html_nodes(ls_html[[x]],"dd") %>% 
    html_text()
}
)
c= data_frame(lema = unlist(a),nilai = unlist(b))
c = mutate(c, kelas = sapply(strsplit(c$nilai," "),"[",1))

type = function(){
type  = html_nodes(ls_html[[1]],"option") %>% html_text()
kelas = unlist(html_nodes(ls_html[[1]],"option") %>% html_attrs())
kelas = kelas[!grepl("selected",kelas)]

ls_type = data_frame(kelas,type)
}

type = type()
c = left_join(c,type,by="kelas")
write_csv(c,"data_kata.csv")
