function [ poro, d_poro_d_p ] = compute_poro( P )

global PARAMS

poro = PARAMS.PORO_REF.*exp(PARAMS.Cr.*(P-PARAMS.PINIT));
d_poro_d_p = PARAMS.Cr.*poro;

end
