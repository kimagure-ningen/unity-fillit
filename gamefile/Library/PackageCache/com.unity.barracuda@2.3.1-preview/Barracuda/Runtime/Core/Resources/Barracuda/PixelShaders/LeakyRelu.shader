Shader "Barracuda/LeakyRelu"
{
    Properties
    {
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "CommonVertexShader.cginc"

            #include "TensorTexture.cginc"

            TENSOR_DECL_O(O)
            TENSOR_DECL(X)

            float _Alpha;

            fixed4 frag (v2f i) : SV_Target
            {
                TENSOR_ARGS2(X, O);
				
                uint n, h, w, c4;
                O.GetPositionFromUV(i.uv, n, h, w, c4);
                float4 v = X.Get4(n, h, w, c4);

                v = max(v, _Alpha * v);

                return v;
            }
            ENDCG
        }
    }
}
