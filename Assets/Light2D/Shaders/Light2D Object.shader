Shader "Light2D/Light2D Object"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			float4 _Color;

			inline float DecFloatRGBA(float4 enc)
			{
				uint ex = (uint)(enc.x * 255);
				uint ey = (uint)(enc.y * 255);
				uint ez = (uint)(enc.z * 255);
				uint ew = (uint)(enc.w * 255);
				uint v = (ex << 24) + (ey << 16) + (ez << 8) + ew;
				return v / (256.0f * 256.0f * 256.0f * 256.0f);
			}

			float4 frag(v2f i) : SV_Target
			{
				return float4(i.vertex.xy / _ScreenParams.xy, DecFloatRGBA(_Color), 1);
			}
			ENDCG
		}
	}
}
