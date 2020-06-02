using ToolsPN

using Plots: plotly, plot, plot!

function peakpos_test()
    y, fs = ToolsPN.read_emg()
    sig = y[2001:10000, 1]
    pk = peakpos(sig, 0.075, 0.05)
    plotly()
    p = plot(sig)
    plot!(pk, sig[pk], line=:stem, marker=:o)
    return p
end

println("Starting...")
p = peakpos_test()
display(p)
println("done")