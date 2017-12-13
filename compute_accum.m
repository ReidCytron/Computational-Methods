function [ accum, d_accum_d_p ] = compute_accum( P )

[poro, d_poro_d_p] = compute_poro(P);
[fvf, d_fvf_d_p] = compute_fvf(P);
accum = poro./fvf;
d_accum_d_p = ( d_poro_d_p./fvf ) - ( poro./fvf./fvf.*d_fvf_d_p );

end
