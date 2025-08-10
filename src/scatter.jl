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

    tr
end
