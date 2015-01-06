get.cog<-
function(zdist, centre=NULL){
#Details {{{
#function returns the FHWM of the image from
#*maxima*, in pixels.
#}}}

  #Setup Radius-map {{{
  if (is.null(centre)) { centre<-as.numeric(which(zdist==max(zdist), arr.ind=TRUE)) }
  im.rad.x<-min(centre[1],length(zdist[,1])-centre[1])-1
  im.rad.y<-min(centre[2],length(zdist[1,])-centre[2])-1
  lim<-c(centre[1]-im.rad.x, centre[1]+im.rad.x, centre[2]-im.rad.y, centre[2]+im.rad.y)
  x = seq(floor(-im.rad.x), floor(im.rad.x), length=im.rad.x*2+1)
  y = seq(floor(-im.rad.y), floor(im.rad.y), length=im.rad.y*2+1)
  xy = expand.grid(x,y)
  r=sqrt(xy[,1]^2+xy[,2]^2)
  #}}}
  #Calculate COG {{{
  tmp.order<-order(r)
  zvec<-as.numeric(zdist[lim[1]:lim[2],lim[3]:lim[4]])
  zbin<-zvec[tmp.order]
  cog<-data.frame(x=r[tmp.order],y=cumsum(zbin))
  #}}}
  #Return FWHM {{{
  return=cog
  #}}}
}
