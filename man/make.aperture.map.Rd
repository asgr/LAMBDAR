\name{make.aperture.map}
\alias{make.aperture.map}
%- Also NEED an `\alias' for EACH other topic documented here.
\title{
Create a Full Mask
}
\description{
__This function is not designed to be called directly, but rather is an internal function to measure.fluxes__

Create a full image mask of all smaller masks/apertures which are input. The full mask is of dimension fullmaskdim.
Pixel locations for the placement of smaller masks on large mask are determined from the
input variables x, y.
}
\usage{
make.aperture.map(outenv=parent.env(environment()),
masks, fullmaskdim, env=NULL, subs=NULL)
}
%- maybe also `usage' for other objects documented here.
\arguments{
  \item{outenv}{
environment; the environment where the returned values are to be stored. If not provided, outenv defaults to the input env.
}
  \item{masks}{
numeric length(m) list of (n,n) arrays; length (m) list of (n,n) stamps, each containing an aperture mask.
}
  \item{fullmaskdim}{
numeric (2) vector; fullmaskdim[1] is the x-dimension of the full mask. fullmaskdim[2] is the y-dimension. fullmaskdim values must be > submask width.
}
  \item{env}{
environment; the environment containing the parameters used in `measure.fluxes'
}
  \item{subs}{
numeric length(k) vector; the subset of apertures to add to the image. Default NULL is treated as 1:length(m).
}
}
%%\details{
%%  ~~ If necessary, more details than the description above ~~
%%}
\value{
array; full mask, with dimensions fullmaskdim, of smaller masks placed in their appropriate locations.
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
%%\examples{

%%}
% Add one or more standard keywords, see file `KEYWORDS' in the
% R documentation directory.
\keyword{ Aperture }
\keyword{ Deblend }
\keyword{ Imaging }% __ONLY ONE__ keyword per line
