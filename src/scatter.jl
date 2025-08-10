function Makie.plot!(tr::TernaryScatter)

    # create observables
    dpoints = Observable(Point2f[])

    function update_plot(xs, ys, zs)
        empty!(dpoints[])
        for (x, y, z) in zip(xs, ys, zs)
            carts = R * [x, y, z]
            push!(dpoints[], Point2f(carts[2], carts[3]))
        end
    end

    Makie.Observables.onany(update_plot, tr[:x], tr[:y], tr[:z])

    update_plot(tr[:x][], tr[:y][], tr[:z][])

    # plot data points
    kwargs = Dict{Symbol, Any}()
    if haskey(tr, :colorrange)
        kwargs[:colorrange] = tr[:colorrange][]
    end
    if haskey(tr, :colormap)
        kwargs[:colormap] = tr[:colormap][]
    end

    scatter!(
        tr,
        dpoints;
        color = tr.color[],
        marker = tr.marker[],
        markersize = tr.markersize[],
        kwargs...,
    )

    # hack: draw a white triangle to clip the scatter points outside of the axes
    s = 0.1
    p1 = r1 - [cosd(30), sind(30)] * s
    p2 = r2 + [cosd(30), -sind(30)] * s
    p3 = r3 + [0, s]
    # polygon with hole
    p = Makie.Polygon(
        Point2f[p1, p2, p3, p1],
        [Point2f[r1, r2, r3, r1]],
    )
    poly!(tr, p, color = :white)

    tr
end

function Makie.extract_colormap(plot::TernaryScatter)
    # ignore the polygon
    return Makie.extract_colormap(plot.plots[1])
end
