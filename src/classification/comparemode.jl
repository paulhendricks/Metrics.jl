_ambiguous() = throw(ArgumentError("Can't infer the comparison mode because argument types are ambigous. Please specify the desired CompareMode manually."))

"""
    comparemode(target, output)

Trys to automatically infer the compare mode for the given
structure and values in `target` and `output`.
"""
comparemode(target, output) = _ambiguous()

comparemode(target::AbstractVector{Bool}, output::AbstractArray{Bool}) =
    LabelEnc.FuzzyBinary()

# Generate the Bool combinations to avoid ambuguity warnings
comparemode(target::Bool, output::Bool) = LabelEnc.FuzzyBinary()
for _T2 in (:Bool, :Real, :Any)
    @eval begin
        comparemode(target::AbstractVector{T2}, output::AbstractArray{Bool}) where {T2<:$_T2} = LabelEnc.FuzzyBinary()
        comparemode(target::AbstractVector{Bool}, output::AbstractArray{T2}) where {T2<:$_T2} = LabelEnc.FuzzyBinary()
    end
    if _T2 != :Bool
        @eval begin
            comparemode(target::$_T2, output::Bool) =
                LabelEnc.FuzzyBinary()
            comparemode(target::Bool, output::$_T2) =
                LabelEnc.FuzzyBinary()
        end
    end
end

# Not enough information available to decide for binary,
# because we don't want to infer an arbitrary label as positive.
# In this case we decide for MultiClass.
function comparemode(target::AbstractVector, output::AbstractArray)
    labels = sort(union(target, output))
    labelenc(labels)
end
