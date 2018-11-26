Shader "Hidden/DebugRaytracer"
{
	Properties
	{
		_MainTex("Jump Flood Texture", 2D) = "black" {}
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

			sampler2D _MainTex;
			sampler2D _ColorTex;

			float samples;
			float sdfBorder;
			float maxBrightness;
			float4 ambient;

			#define MAX_DIST	1.41421356237
			#define EPSILON		1.e-5
			#define MAX_ITER	32

			float random(float2 co)
			{
				return frac(sin(dot(co, float2(12.93567367898, 78.23092373))) * 43758.545313623);
			}

			void sampleDF(in float2 p, out float3 color, out float dist)
			{
				float4 colorTex = tex2D(_ColorTex, p).rgba;
				if (colorTex.a > 0)
				{
					dist = 0;
				}
				else
				{
					float2 seed = tex2D(_MainTex, p).xy;
					dist = distance(seed, p);
				}

				if (dist < EPSILON)
				{
					color = colorTex * maxBrightness;
				}
			}

			int trace(float2 p, float2 dir, out float3 c, int iter)
			{
				float d;
				for (int i = 0; i < MAX_ITER; i++)
				{
					sampleDF(p, c, d);
					if (d > MAX_DIST || p.x < 0 || p.y < 0 || p.x > 1 || p.y > 1) break;
					if (d < EPSILON) return iter;
					p += dir * d / float2(_ScreenParams.x / _ScreenParams.y, 1);
					iter++;
				}
				c = ambient.rgb * ambient.a;
				return iter;
			}

			float4 frag(v2f i) : SV_Target
			{
				float2 p = i.uv * (1. - sdfBorder) + sdfBorder / 2.;

				float3 col = ambient;
				int iter = 0;
				for (float f = 0.; f < samples; f++)
				{
					float3 c;
					float t = (f + random(i.uv + f + frac(_Time.y))) / samples * 2. * 3.1415;
					iter += trace(p, float2(cos(t), sin(t)), c, iter);
					col += c;
				}
				col /= samples;
				float avgIter = float(iter) / (samples * float(MAX_ITER));

				return float4((col.r + col.g + col.b) / 3. + float3(avgIter, 0, 0), 1);
			}
			ENDCG
		}

	}
}
