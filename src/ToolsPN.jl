module ToolsPN

using WAV: wavread

include("./peakpos.jl")

export peakpos

function read_emg()
    fDir = raw"C:\Users\Praneeth\Documents\BYB\carotid breathing 20200305"
    fName = "Breathing Ultrasound 01 in-phase BYB_Recording_2020-03-05_13.34.15.wav"
    read_emg(fDir, fName)
end

function read_emg(fDir::String, fName::String)
    y, Fs = wavread(joinpath(fDir, fName))
    return y, Fs
end

end # module
