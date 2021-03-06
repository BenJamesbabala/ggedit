class_layer=function(p){
  plot_aes=as.character(p$mapping)
  aes.nm=names(p$mapping)[plot_aes!='NULL']
  plot_aes=plot_aes[plot_aes!='NULL']
  plot_aes=data.frame(var=unlist(plot_aes),stringsAsFactors = F)
  plot_aes$aes=aes.nm
  plot_aes$class=unlist(sapply(plot_aes$var,function(x) class(p$data[,x])))
  plot_aes$layer='plot'
  
  layer_aes=lapply(p$layers,function(x) data.frame(var=as.character(x$mapping),aes=names(x$mapping),stringsAsFactors = F))
  names(layer_aes)=geom_list(p)
  layer_aes=ldply(layer_aes,.id = 'layer')
  layer_aes$class=sapply(layer_aes$var,function(x) if(x%in%names(p$data)) class(p$data[,x]))
  layer_bind=rbind(plot_aes,layer_aes)
  layer_bind$level.num=sapply(layer_bind$var,function(x) if(x%in%names(p$data)) length(unique(p$data[,x])))
  return(layer_bind)
}