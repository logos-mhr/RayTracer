#define _USE_MATH_DEFINES
#include "material.cuh"
#include <cmath>
#define INV_PI 0.318309892f
#define MAXN 0xffffffffu


CUDA_FUNC float3 Lambertian::f(Ray &wo, Ray &wi)const
{
    return color * INV_PI;
}

CUDA_FUNC float3 Lambertian::sample_f(Ray &wo, Ray *wi, float *pdf, const float2 &sample) const
{
    if (pdf == nullptr || wi == nullptr)
        return make_float3(0.0f);

    float theta = sample.x * 2.0f * M_PI, phi = sample.y * M_PI_2;
    float sinPhi = sin(phi), cosPhi = cos(phi);

    *wi = Ray(make_float3(0.0f), make_float3(sin(theta) * sinPhi, cosPhi, cos(theta) * sinPhi));
    *pdf = cosPhi * INV_PI;

    return f(wo, *wi);
}

CUDA_FUNC bool Lambertian::isSpecular() const
{
    return false;
}