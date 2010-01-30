function results = vl_test_alldist(varargin)
vl_test_init ;

function s = setup()
vl_twister('state', 0) ;
s.X = 3.1 * vl_twister(10,10) ;
s.Y = 4.7 * vl_twister(10,7) ;

function test_self(s)
vl_assert_almost_equal(...
  vl_alldist(s.X, 'kl2'), ...
  makedist(@(x,y) x*y, s.X, s.X), ...
  1e-6) ;

function test_distances(s)
dists = {'chi2', 'l2', 'l1', 'kchi2', 'kl2', 'kl1'} ;
distsEquiv = { ...
  @(x,y) (x-y)^2 / (x + y), ...
  @(x,y) (x-y)^2, ...
  @(x,y) abs(x-y), ...
  @(x,y) 2 * (x*y) / (x + y), ...
  @(x,y) x*y, ...
  @(x,y) min(x,y) } ;
types = {'single', 'double'} ;

for simd = [0 1]
  for d = 1:length(dists)
    for t = 1:length(types)
      vl_simdctrl(simd) ;
      X = feval(str2func(types{t}), s.X) ;
      Y = feval(str2func(types{t}), s.Y) ;
      vl_assert_almost_equal(...
        vl_alldist(X,Y,dists{d}), ...
        makedist(distsEquiv{d},X,Y), ...
        1e-4, ...
        'alldist failed for dist=%s type=%s simd=%d', ...
        dists{d}, ...
        types{t}, ...
        simd) ;
    end
  end
end

function D = makedist(cmp,X,Y)
[d,m] = size(X) ;
[d,n] = size(Y) ;
D = zeros(m,n) ;
for i = 1:m
  for j = 1:n
    acc = 0 ;
    for k = 1:d
      acc = acc + cmp(X(k,i),Y(k,j)) ;
    end
    D(i,j) = acc ;
  end
end
conv = str2func(class(X)) ;
D = conv(D) ;