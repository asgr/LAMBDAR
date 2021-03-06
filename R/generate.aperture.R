#
#
#
generate.aperture <-
function(x,y,xstep,ystep,xcen=0,ycen=0,axrat=1,axang=0,majax=1,deg=TRUE,resample.upres=2,resample.iterations=9,pixscale=FALSE,peakscale=FALSE,peak=1){

if(majax>0){

 if(resample.iterations>0){

  origx=x
  origy=y
  origxstep=xstep
  origystep=ystep

  mastercat={}
  weight=1
  newID=1:length(x)

  for(i in 1:resample.iterations){
   check=checkgrid(x=x,y=y,xstep=xstep,ystep=ystep,xcen=xcen,ycen=ycen,axrat=axrat,axang=axang,majax=majax,deg=deg)
   if(any(check$logic[,'empty'])){mastercat=rbind(mastercat,cbind(newID[check$logic[,'empty']],0))}
   if(any(check$logic[,'full'])){mastercat=rbind(mastercat,cbind(newID[check$logic[,'full']],weight))}
   regrid=reexpand.grid(x[check$logic[,'part']],y[check$logic[,'part']],xstep=xstep,ystep=ystep,id=newID[check$logic[,'part']],resample.upres=resample.upres)
   x=regrid$x
   y=regrid$y
   newID=regrid$id
   xstep=regrid$xstep
   ystep=regrid$ystep
   weight=weight/(resample.upres^2)
  }

  check=checkgrid(x=x,y=y,xstep=xstep,ystep=ystep,xcen=xcen,ycen=ycen,axrat=axrat,axang=axang,majax=majax,deg=deg)
  if(any(check$logic[,'empty'])){mastercat=rbind(mastercat,cbind(newID[check$logic[,'empty']],0))}
  if(any(check$logic[,'full'])){mastercat=rbind(mastercat,cbind(newID[check$logic[,'full']],weight))}
  if(any(check$logic[,'mid']==FALSE & check$logic[,'part'])){mastercat=rbind(mastercat,cbind(newID[check$logic[,'mid']==FALSE & check$logic[,'part']],0))}
  if(any(check$logic[,'mid'] & check$logic[,'part'])){mastercat=rbind(mastercat,cbind(newID[check$logic[,'mid'] & check$logic[,'part']],weight))}

  rebinID=as.numeric(names(table(mastercat[,1])[table(mastercat[,1])>1]))

  sumcat={}

  for(i in 1:length(rebinID)){
   sumcat=rbind(sumcat,cbind(rebinID[i],sum(mastercat[mastercat[,1]==rebinID[i],2])))
  }
  mastercat=rbind(mastercat[!mastercat[,1] %in% rebinID,],sumcat)
  mastercat=mastercat[order(mastercat[,1]),2]
  mastercat=cbind(origx,origy,mastercat)
  if(pixscale){mastercat[,3]=mastercat[,3]*origxstep*origystep}
 } else if(resample.iterations==0){

  mastercat={}
  weight=1

  check=checkgrid(x=x,y=y,xstep=xstep,ystep=ystep,xcen=xcen,ycen=ycen,axrat=axrat,axang=axang,majax=majax,deg=deg)
  if(any(check$logic[,'empty'])){mastercat=rbind(mastercat,cbind(which(check$logic[,'empty']),0))} #Empty Pix
  if(any(check$logic[,'full'])){mastercat=rbind(mastercat,cbind(which(check$logic[,'full']),1))} #Full Pix
  if(any(check$logic[,'part'] & !(check$logic[,'mid'] & (check$Npart==0)))){mastercat=rbind(mastercat,cbind(which(check$logic[,'part'] & !(check$logic[,'mid'] & (check$Npart==0))),(check$Npart[which(check$logic[,'part'] & !(check$logic[,'mid'] & (check$Npart==0)))]/4)))} #Pix with Npart corners covered
  if(any(check$logic[,'part'] & (check$logic[,'mid'] & (check$Npart==0)))){mastercat=rbind(mastercat,cbind(which(check$logic[,'part'] & (check$logic[,'mid'] & (check$Npart==0))),1))} #Pix with Middle covered and no corners covered (all ap in 1 pix)

  mastercat=mastercat[order(mastercat[,1]),2]
  mastercat=cbind(x,y,mastercat)
  if(pixscale){mastercat[,3]=mastercat[,3]*xstep*ystep}

 }else{
  mastercat={}
  weight=1

  check=checkgrid(x=x,y=y,xstep=xstep,ystep=ystep,xcen=xcen,ycen=ycen,axrat=axrat,axang=axang,majax=majax,deg=deg)
  if(any(check$logic[,'empty'])){mastercat=rbind(mastercat,cbind(which(check$logic[,'empty']),0))}
  if(any(check$logic[,'full'])){mastercat=rbind(mastercat,cbind(which(check$logic[,'full']),weight))}
  if(any(check$logic[,'mid']==FALSE & check$logic[,'part'])){mastercat=rbind(mastercat,cbind(which(check$logic[,'mid']==FALSE & check$logic[,'part']),0))}
  if(any(check$logic[,'mid'] & check$logic[,'part'])){mastercat=rbind(mastercat,cbind(which(check$logic[,'mid'] & check$logic[,'part']),weight))}

  mastercat=mastercat[order(mastercat[,1]),2]
  mastercat=cbind(x,y,mastercat)
  if(pixscale){mastercat[,3]=mastercat[,3]*xstep*ystep}
 }
 if(peakscale){
  currentpeak = max(mastercat[, 3])
       mastercat[, 3] = mastercat[, 3] * peak/currentpeak
 }
}else{
 mastercat=cbind(x=x,y=y,mastercat=0)
 if(peakscale){
  mastercat[x+xstep/2>=xcen & x-xstep/2<=xcen & y+ystep/2>=ycen & y-ystep/2<=ycen,3]=1/length(which(x+xstep/2>=xcen & x-xstep/2<=xcen & y+ystep/2>=ycen & y-ystep/2<=ycen))
 }
}
return=mastercat
}

