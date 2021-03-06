\name{write.fits.image.file}
\alias{write.fits.image.file}
\alias{make.fits.header}
%- Also NEED an `\alias' for EACH other topic documented here.
\title{
Write FITS Image to File
}
\description{
Write an input image to file, using the standard FITS format.
}
\usage{
write.fits.image.file(filename, image, header_in, xsize = NA,
ysize = NA, xcent = NA, ycent = NA, pixeloffset = NA,
nochange = FALSE, verbose = FALSE, diagnostic = FALSE)
make.fits.header(hdr)
}
%- maybe also `usage' for other objects documented here.
\arguments{
  \item{filename}{
string; The path to, and filename of, the output image
}
  \item{image}{
numeric (p,q) array; the image to be output
}
  \item{header_in}{
list; a FITS header, usually a duplicate of the original header that the new image was derived from.
}
  \item{xsize}{
numeric; The new x-axis length to be written to the fits header (pixels). Only used if nochange == FALSE
}
  \item{ysize}{
numeric; The new y-axis size to be written to the fits header (pixels). Only used if nochange == FALSE
}
  \item{xcent}{
numeric; The new reference pixel for the x-axis, to be written to the fits header (pixel). Only used if nochange == FALSE
}
  \item{ycent}{
numeric; The new reference pixel for the y-axis, to be written to the fits header (pixel). Only used if nochange == FALSE
}
  \item{pixeloffset}{
numeric; The magnitude of the offset between the original pixel location paramters (from header_in), and what we wish to output.
}
  \item{nochange}{
logical; if TRUE, the new image will be output with the header_in header. Otherwise, new values will be added as above.
}
  \item{diagnostic}{
logical; if TRUE, then perform diagnostic checks and outputs
}
  \item{verbose}{
logical; if TRUE, then perform verbose outputs
}
  \item{hdr}{
data.frame; In the form of a fits header, this will be converted to a string which can be output as a binary fits header
}
}
%%\details{
%%  ~~ If necessary, more details than the description above ~~
%%}
\value{
NULL; Output is to file
character; fits header to be written to file
}
%%\references{
%% ~put references to the literature/web site here ~
%%}
\author{
Angus H Wright{ ICRAR}
 {\email{angus.wright@icrar.org}}
}
%%\note{
%%  ~~further notes~~
%%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\link{measure.fluxes}, \link{flux.measurements}
}
\examples{

}
% Add one or more standard keywords, see file `KEYWORDS' in the
% R documentation directory.
\keyword{ Output }
