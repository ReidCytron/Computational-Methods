function [ trans, d_trans_d_p ] = compute_trans( P )

global PARAMS

[fvf, d_fvf_d_p] = compute_fvf(P);
trans = 1.0./fvf./PARAMS.VIS;
d_trans_d_p = -(1.0./PARAMS.VIS)./fvf./fvf.*d_fvf_d_p;

end
