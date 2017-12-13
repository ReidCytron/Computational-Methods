function [ fvf, d_fvf_d_p ] = compute_fvf( P )

global PARAMS
y = PARAMS.Cf.*(P-PARAMS.PINIT);
fvf = PARAMS.FVF_REF./(1+y+0.5.*y.*y);
d_fvf_d_p = - (fvf.^2./PARAMS.FVF_REF).*PARAMS.Cf.*(1.0+y);

end
