using Statistics

struct IdxVal{I <: Integer, V <: Real}
    idx::I
    val::V
end

"""
peakpos - Detect peaks in a real-world signal

Inputs:
    y (AbstractVector{<:Real}) is a 1-dimensional signal
    delta_left (Real) is the rise threshold, defaults to 8 times the standard deviation of y
    delta_right (Real) is the fall threshold, defaults to delta_left

Returns:
    Index positions of the peaks

Usage:
    peakpos(y)
"""
function peakpos(y::AbstractVector{<:Real})
    delta = 8*std(y)
    peakpos(y, delta, delta)
end

function peakpos(y::AbstractVector{<:Real}, delta::Real)
    peakpos(y, delta, delta)
end

function peakpos(y::AbstractVector{<:Real}, delta_left::Real, delta_right::Real)
    delta_right = isnan(delta_right) ? delta_left : delta_right
    ret = falses(size(y))
    
    valley1 = peak1 = valley2 = IdxVal(1, y[1])
    for i = 2:length(y)
        this = IdxVal(i, y[i])
        if this.val > peak1.val
            peak1 = this
            if valley2.val < valley1.val
                valley1 = valley2
            end
            valley2 = this
        end
        if this.val < valley2.val
            valley2 = this
            if peak1.val - valley1.val > delta_left && peak1.val - valley2.val > delta_right && peak1.idx > valley1.idx && valley2.idx > peak1.idx
                ret[peak1.idx] = true
                valley1 = this
                peak1 = this
            end
        end
    end
    return findall(ret)
end
