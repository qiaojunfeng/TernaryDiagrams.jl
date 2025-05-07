using GLMakie
using TernaryDiagrams
using JLD2

@load joinpath(pkgdir(TernaryDiagrams), "test", "data.jld2") a1 a2 a3 mus
a1 = a1[1:20]
a2 = a2[1:20]
a3 = a3[1:20]
mus = mus[1:20]

fig = Figure(size = (900, 600))
ax = Axis(fig[1, 1], aspect=DataAspect())

ternarycontourf!(ax, a1, a2, a3, mus; levels = 10)

p = ternaryaxis!(
    ax;
    labelx_arrow = "a1",
    labely_arrow = "a2",
    labelz_arrow = "a3",
    hide_vertex_labels = true,
    # hide_triangle_labels = true,
    hide_arrows = true,
)

xlims!(ax, -0.2, 1.2) # to center the triangle
ylims!(ax, -0.3, 1.1) # to center the triangle
hidedecorations!(ax) # to hide the axis decos

# fig
