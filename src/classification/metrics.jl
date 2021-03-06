# --------------------------------------------------------------------
# prevalence is a bit of an outlier

@reduce_fraction """
Return the fraction of positive observations in `targets`.
Which value denotes "positive" depends on the given (or inferred)
`encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`condition_positive`](@ref)

# Examples


```jldoctest
julia> prevalence([0,1,1,0,1], [1,1,1,0,1])
0.6

julia> prevalence([-1,1,1,-1,1], [1,1,1,-1,1])
0.6

julia> prevalence([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:c))
0.4

julia> prevalence([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.4
  :b => 0.2
  :c => 0.4

julia> prevalence([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.3333333333333333
```
""" ->
prevalence := condition_positive / _length_targets

# --------------------------------------------------------------------

@reduce_fraction """
Return the fraction of positive predicted outcomes in `outputs`
that are true positives according to the correspondig `targets`.
This is also known as "precision" (alias `precision_score`).
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`true_positives`](@ref),
[`predicted_positive`](@ref),
[`true_positive_rate`](@ref) (aka "recall" or "sensitivity"),
[`f_score`](@ref)

# Examples

```jldoctest
julia> precision_score([0,1,1,0,1], [1,1,1,0,1])
0.75

julia> precision_score([-1,1,1,-1,1], [1,1,1,-1,1])
0.75

julia> precision_score([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:c))
0.6666666666666666

julia> precision_score([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 1.0
  :b => 0.0
  :c => 0.666667

julia> precision_score([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.6

julia> precision_score([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.5555555555555555
```
""" ->
positive_predictive_value := true_positives / predicted_positive

const precision_score = positive_predictive_value

# --------------------------------------------------------------------

@reduce_fraction """
Return the fraction of negative predicted outcomes in `outputs`
that are true negatives according to the corresponding `targets`.
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`true_negatives`](@ref),
[`predicted_negative`](@ref)

# Examples

```jldoctest
julia> negative_predictive_value([0,1,1,0,1], [1,1,1,0,1])
1.0

julia> negative_predictive_value([-1,1,1,-1,1], [1,1,1,-1,1])
1.0

julia> negative_predictive_value([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:b))
0.75

julia> negative_predictive_value([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.75
  :b => 0.75
  :c => 1.0

julia> negative_predictive_value([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.8

julia> negative_predictive_value([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.8333333333333334
```
""" ->
negative_predictive_value := true_negatives / predicted_negative

# --------------------------------------------------------------------

@reduce_fraction """
Return the fraction of truly positive observations in `outputs`
that were predicted as positives. This is also known as `recall`
or `sensitivity`. What constitutes "truly positive" depends on to
the corresponding `targets` and the given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`true_positives`](@ref),
[`positive_predictive_value`](@ref) (aka "precision"),
[`true_negative_rate`](@ref) (aka "specificity"),
[`f_score`](@ref)

# Examples

```jldoctest
julia> recall([0,1,1,0,1,1], [1,0,1,0,1,1])
0.75

julia> recall([-1,1,1,-1,1], [1,-1,1,-1,1])
0.6666666666666666

julia> recall([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:a))
0.5

julia> recall([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.5
  :b => 0.0
  :c => 1.0

julia> recall([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.6

julia> recall([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.5
```
""" ->
true_positive_rate := true_positives / condition_positive

const sensitivity = true_positive_rate
const recall = true_positive_rate

# --------------------------------------------------------------------

@reduce_fraction """
Return the fraction of truly negative observations in `outputs`
that were (wrongly) predicted as positives. What constitutes
"truly negative" depends on to the corresponding `targets` and
the given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`true_positives`](@ref),
[`positive_predictive_value`](@ref) (aka "precision"),
[`true_negative_rate`](@ref) (aka "specificity"),
[`f_score`](@ref)

# Examples

```jldoctest
julia> false_positive_rate([0,1,1,0,1], [1,1,1,0,1])
0.5

julia> false_positive_rate([-1,1,1,-1,1], [1,1,1,-1,1])
0.5

julia> false_positive_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:b))
0.25

julia> false_positive_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.0
  :b => 0.25
  :c => 0.333333

julia> false_positive_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.2

julia> false_positive_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.19444444444444442
```
""" ->
false_positive_rate := false_positives / condition_negative

# --------------------------------------------------------------------

@reduce_fraction """
Return the fraction of negative predicted outcomes that are true
negatives according to the corresponding `targets`. This is also
known as `specificity`.
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`true_negatives`](@ref),
[`condition_negative`](@ref),
[`true_positive_rate`](@ref) (aka "recall" or "sensitivity")

# Examples

```jldoctest
julia> true_negative_rate([0,1,1,0,1], [1,1,1,0,1])
0.5

julia> true_negative_rate([-1,1,1,-1,1], [1,1,1,-1,1])
0.5

julia> true_negative_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:b))
0.75

julia> true_negative_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 1.0
  :b => 0.75
  :c => 0.666667

julia> true_negative_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.8

julia> true_negative_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.8055555555555555
```
""" ->
true_negative_rate := true_negatives / condition_negative

const specificity = true_negative_rate

# --------------------------------------------------------------------

@reduce_fraction """
Return the fraction of truely positive observations that were
(wrongly) predicted as negative. What constitutes "truly
positive" depends on to the corresponding `targets` and the given
(or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`false_negatives`](@ref),
[`condition_positive`](@ref)

# Examples

```jldoctest
julia> false_negative_rate([0,1,1,0,1], [1,0,1,0,1])
0.3333333333333333

julia> false_negative_rate([-1,1,1,-1,1], [1,1,1,-1,1])
0.0

julia> false_negative_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:a))
0.5

julia> false_negative_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.5
  :b => 1.0
  :c => 0.0

julia> false_negative_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.4

julia> false_negative_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.5
```
""" ->
false_negative_rate := false_negatives / condition_positive

# --------------------------------------------------------------------

@reduce_fraction """
Return the fraction of positive predicted outcomes in `outputs`
that are false positives according to the corresponding `targets`.
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`false_positives`](@ref),
[`predicted_positive`](@ref),
[`false_omission_rate`](@ref)

# Examples

```jldoctest
julia> false_discovery_rate([0,1,1,0,1], [1,1,1,0,1])
0.25

julia> false_discovery_rate([-1,1,1,-1,1], [1,1,1,-1,1])
0.25

julia> false_discovery_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:b))
1.0

julia> false_discovery_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.0
  :b => 1.0
  :c => 0.333333

julia> false_discovery_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.4

julia> false_discovery_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.4444444444444444
```
""" ->
false_discovery_rate := false_positives / predicted_positive

# --------------------------------------------------------------------

@reduce_fraction """
Return the fraction of negative predicted outcomes in `outputs`
that are false negatives according to the corresponding `targets`.
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`false_negatives`](@ref),
[`predicted_negative`](@ref),
[`false_discovery_rate`](@ref)

# Examples

```jldoctest
julia> false_omission_rate([0,1,1,0,1], [1,1,1,0,1])
0.0

julia> false_omission_rate([-1,1,1,-1,1], [1,1,1,-1,1])
0.0

julia> false_omission_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:b))
0.25

julia> false_omission_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.25
  :b => 0.25
  :c => 0.0

julia> false_omission_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.2

julia> false_omission_rate([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.16666666666666666
```
""" ->
false_omission_rate := false_negatives / predicted_negative

# --------------------------------------------------------------------
# MAP FRACTION

@map_fraction """
Compute the positive likelihood ratio for the given `outputs` and
`targets`. It is a useful meassure for assessing the quality of a
diagnostic test and is defined as `sensitivity / (1 -
specificity)`. This can also be written as `true_positive_rate /
false_positive_rate`.
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`true_positive_rate`](@ref) (aka "recall" or "sensitivity"),
[`false_positive_rate`](@ref),
[`negative_likelihood_ratio`](@ref),
[`diagnostic_odds_ratio`](@ref)

# Examples

```jldoctest
julia> positive_likelihood_ratio([0,1,1,0,1], [1,1,1,0,1])
2.0

julia> positive_likelihood_ratio([-1,1,1,-1,1], [1,1,1,-1,1])
2.0

julia> positive_likelihood_ratio([:b,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:c))
3.0

julia> positive_likelihood_ratio([:b,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.0
  :b => 0.0
  :c => 3.0

julia> positive_likelihood_ratio([:b,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
1.3333333333333335

julia> positive_likelihood_ratio([:b,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
1.090909090909091
```
""" ->
positive_likelihood_ratio := true_positive_rate / false_positive_rate

# --------------------------------------------------------------------

@map_fraction """
Compute the negative likelihood ratio for the given `outputs` and
`targets`. It is a useful meassure for assessing the quality of a
diagnostic test and is defined as `(1 - sensitivity) /
specificity`. This can also be written as `false_negative_rate /
true_negative_rate`.
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`false_negative_rate`](@ref),
[`true_negative_rate`](@ref) (aka "specificity"),
[`positive_likelihood_ratio`](@ref),
[`diagnostic_odds_ratio`](@ref)

# Examples

```jldoctest
julia> negative_likelihood_ratio([0,1,1,0,1], [1,0,1,0,1])
0.6666666666666666

julia> negative_likelihood_ratio([-1,1,1,-1,1], [1,-1,1,-1,1])
0.6666666666666666

julia> negative_likelihood_ratio([:b,:b,:a,:c,:c], [:a,:c,:b,:c,:c], LabelEnc.OneVsRest(:a))
1.3333333333333333

julia> negative_likelihood_ratio([:b,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 1.33333
  :b => 1.5
  :c => 0.0

julia> negative_likelihood_ratio([:b,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.8571428571428572

julia> negative_likelihood_ratio([:b,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:macro)
0.9600000000000002
```
""" ->
negative_likelihood_ratio := false_negative_rate / true_negative_rate

# --------------------------------------------------------------------

@map_fraction """
Compute the diagnostic odds ratio (DOR) for the given `outputs`
and `targets`. It is a useful meassure of the effectiveness of a
diagnostic test and is defined as `positive_likelihood_ratio /
negative_likelihood_ratio`.
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS

# See also

[`positive_likelihood_ratio`](@ref),
[`negative_likelihood_ratio`](@ref)

# Examples

```jldoctest
julia> diagnostic_odds_ratio([0,1,1,0,1], [1,0,1,0,1])
2.0

julia> diagnostic_odds_ratio([-1,1,1,-1,1], [1,-1,1,-1,1])
2.0

julia> diagnostic_odds_ratio([:b,:b,:a,:c,:c], [:a,:b,:b,:c,:c], LabelEnc.OneVsRest(:b))
2.0

julia> diagnostic_odds_ratio([:b,:b,:a,:c,:c], [:a,:b,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.0
  :b => 2.0
  :c => Inf

julia> diagnostic_odds_ratio([:b,:b,:a,:c,:c], [:a,:b,:b,:c,:c], avgmode=:micro)
5.999999999999999

julia> diagnostic_odds_ratio([:b,:b,:a,:c,:c], [:a,:b,:b,:c,:c], avgmode=:macro)
4.142857142857143
```
""" ->
diagnostic_odds_ratio := positive_likelihood_ratio / negative_likelihood_ratio
# FIXME: maybe check if both false negatives and false positives are zero

# --------------------------------------------------------------------

"""
    accuracy(targets, outputs, [encoding]; [normalize = true]) -> Float64

Compute the fraction of correctly predicted outcomes in `outputs`
according to the given true `targets`. This is known as the
classification accuracy.

$FRAC_ENCODING_DESCR

# Arguments

- `targets::AbstractArray`: The array of ground truths
  ``\\mathbf{y}``.

- `outputs::AbstractArray`: The array of predicted outputs
  ``\\mathbf{\\hat{y}}``.

- `encoding`: Optional. Specifies the possible values in
  `targets` and `outputs` and their interpretation (e.g. what
  constitutes as a positive or negative label, how many labels
  exist, etc). It can either be an object from the namespace
  `LabelEnc`, or a vector of labels.

- `normalize::Bool`: Optional keyword argument. If `true`, the
  function will return the fraction of correctly classified
  observations in `outputs`. Otherwise it returns the total
  number. Defaults to `true`.

# See also

[`correctly_classified`](@ref), [`f_score`](@ref)

# Examples

```jldoctest
julia> accuracy([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c])
0.6

julia> accuracy([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], normalize=false)
3.0

julia> accuracy([1,0,0,1,1], [1,-1,-1,-1,1], LabelEnc.FuzzyBinary())
0.8
```
"""
function accuracy(targets::AbstractArray,
                  outputs::AbstractArray,
                  encoding::BinaryLabelEncoding;
                  normalize = true)
    @_dimcheck length(targets) == length(outputs)
    tp::Int = 0; tn::Int = 0
    @inbounds for i = 1:length(targets)
        target = targets[i]
        output = outputs[i]
        tp += true_positives(target, output, encoding)
        tn += true_negatives(target, output, encoding)
    end
    correct = tp + tn
    normalize ? Float64(correct/length(targets)) : Float64(correct)
end

function accuracy(object; normalize = true)
    correct = true_positives(object) + true_negatives(object)
    normalize ? Float64(correct/nobs(object)) : Float64(correct)
end

function accuracy(targets::AbstractArray,
                  outputs::AbstractArray,
                  encoding::LabelEncoding;
                  normalize = true)
    @_dimcheck length(targets) == length(outputs)
    correct::Int = 0
    @inbounds for i = 1:length(targets)
        correct += targets[i] == outputs[i]
    end
    normalize ? Float64(correct/length(targets)) : Float64(correct)
end

function accuracy(targets::AbstractArray,
                  outputs::AbstractArray,
                  labels::AbstractVector;
                  normalize = true)
    accuracy(targets, outputs, LabelEnc.NativeLabels(labels), normalize = normalize)::Float64
end

function accuracy(targets::AbstractArray,
                  outputs::AbstractArray;
                  normalize = true)
    accuracy(targets, outputs, _labelenc(targets, outputs), normalize = normalize)::Float64
end

# --------------------------------------------------------------------

"""
    f_score(targets, outputs, [encoding], [avgmode], [beta = 1]) -> Float64

Compute the F-score for the `outputs` given the `targets`.
The F-score is a measure for accessing the quality of binary
predictor by considering both *recall* and the *precision*.
Which value(s) denote "positive" or "negative" depends on the
given (or inferred) `encoding`.

$FRAC_ENCODING_DESCR

$AVGMODE_DESCR

# Arguments

$FRAC_ARGS
- `beta::Number`: Optional keyword argument. Used to balance the
  importance of recall vs precision. The default `beta = 1`
  corresponds to the harmonic mean. A value of `beta > 1` weighs
  recall higher than precision, while a value of `beta < 1`
  weighs recall lower than precision.

# See also

[`accuracy`](@ref),
[`positive_predictive_value`](@ref) (aka "precision"),
[`true_positive_rate`](@ref) (aka "recall" or "sensitivity")

# Examples

```jldoctest
julia> recall([1,0,0,1,1], [1,0,0,0,1])
0.6666666666666666

julia> precision_score([1,0,0,1,1], [1,0,0,0,1])
1.0

julia> f_score([1,0,0,1,1], [1,0,0,0,1])
0.8

julia> f_score([1,0,0,1,1], [1,0,0,0,1], beta = 2)
0.7142857142857143

julia> f_score([1,0,0,1,1], [1,0,0,0,1], beta = 0.5)
0.9090909090909091

julia> f_score([1,0,0,1,1], [1,-1,-1,-1,1], LabelEnc.FuzzyBinary())
0.8

julia> f_score([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c]) # avgmode=:none
Dict{Symbol,Float64} with 3 entries:
  :a => 0.666667
  :b => 0.0
  :c => 0.8

julia> f_score([:a,:b,:a,:c,:c], [:a,:c,:b,:c,:c], avgmode=:micro)
0.6
```
"""
function f_score(targets::AbstractArray,
                 outputs::AbstractArray,
                 encoding::BinaryLabelEncoding,
                 avgmode::AvgMode.None,
                 β::Number = 1.0)
    @_dimcheck length(targets) == length(outputs)
    β² = abs2(β)
    tp::Int = 0; fp::Int = 0; fn::Int = 0
    @inbounds for I in eachindex(targets, outputs)
        target = targets[I]
        output = outputs[I]
        tp += true_positives(target,  output, encoding)
        fp += false_positives(target, output, encoding)
        fn += false_negatives(target, output, encoding)
    end
    (1+β²)*tp / ((1+β²)*tp + β²*fn + fp)
end

f_score(object; beta = 1.0) = f_score(object, beta)
function f_score(object, β::Number)
    β² = abs2(β)
    tp = true_positives(object)
    fp = false_positives(object)
    fn = false_negatives(object)
    (1+β²)*tp / ((1+β²)*tp + β²*fn + fp)
end

# Micro averaging multiclass f-score
function f_score(targets::AbstractArray,
                 outputs::AbstractArray,
                 encoding::LabelEncoding,
                 avgmode::AvgMode.Micro,
                 β::Number = 1.0)
    r = true_positive_rate(targets, outputs, encoding, avgmode)
    p = positive_predictive_value(targets, outputs, encoding, avgmode)
    β² = abs2(β)
    ((1+β²)*(p*r)) / (β²*(p+r))
end

# Macro averaging multiclass f-score
function f_score(targets::AbstractArray,
                 outputs::AbstractArray,
                 encoding::LabelEncoding,
                 avgmode::AverageMode,
                 β::Number = 1.0)
    @_dimcheck length(targets) == length(outputs)
    labels = label(encoding)
    n = length(labels)
    ovr = [LabelEnc.OneVsRest(l) for l in labels]
    precision_ = zeros(n); recall_ = zeros(n)
    @inbounds for j = 1:n
        recall_[j] = true_positive_rate(targets, outputs, ovr[j])
        precision_[j] = positive_predictive_value(targets, outputs, ovr[j])
    end
    β² = abs2(β)
    scores = ((1.0 .+ β²) .* (precision_ .* recall_)) ./ (β² .* (precision_ .+ recall_))
    scores .= ifelse.(isequal.(scores, NaN), zero(eltype(scores)), scores)
    aggregate_score(scores, labels, avgmode)
end

aggregate_score(score, labels, ::AvgMode.None) = Dict(Pair.(labels, score))
aggregate_score(score, labels, ::AvgMode.Macro) = mean(score)
aggregate_score(score, labels, ::AvgMode.Micro) = error("unreachable")

f_score(targets, outputs, encoding::LabelEncoding, β::Number) =
    f_score(targets, outputs, encoding, AvgMode.None(), β)

f_score(targets, outputs, labels::AbstractVector, args...) =
    f_score(targets, outputs, LabelEnc.NativeLabels(labels), args...)

f_score(targets, outputs, β::Number) =
    f_score(targets, outputs, _labelenc(targets, outputs), AvgMode.None(), β)

f_score(targets, outputs, avgmode::AverageMode, β::Number = 1.0) =
    f_score(targets, outputs, _labelenc(targets, outputs), avgmode, β)

f_score(targets, outputs; avgmode=AvgMode.None(), beta::Number = 1.0) =
    f_score(targets, outputs, convert(AverageMode, avgmode), beta)

f_score(targets, outputs, encoding; avgmode=AvgMode.None(), beta::Number = 1.0) =
    f_score(targets, outputs, encoding, convert(AverageMode, avgmode), beta)

# --------------------------------------------------------------------

"""
    f1_score(targets, outputs, [encoding], [avgmode])

Same as [`f_score`](@ref), but with `beta` fixed to 1.
"""
f1_score(object) = f_score(object, 1.0)

f1_score(targets, outputs, enc::LabelEncoding) =
    f_score(targets, outputs, enc, 1.0)

f1_score(targets, outputs, labels::AbstractVector, args...) =
    f_score(targets, outputs, labels, args..., 1.0)

f1_score(targets, outputs, avgmode::AverageMode) =
    f_score(targets, outputs, avgmode, 1.0)

f1_score(targets, outputs, enc::LabelEncoding, avgmode::AverageMode) =
    f_score(targets, outputs, enc, avgmode, 1.0)

f1_score(targets, outputs, enc; avgmode=AvgMode.None()) =
    f_score(targets, outputs, enc, convert(AverageMode, avgmode), 1.0)

f1_score(targets, outputs; avgmode=AvgMode.None()) =
    f_score(targets, outputs, convert(AverageMode, avgmode), 1.0)

# --------------------------------------------------------------------

# TODO: make this work for AvgMode and LabelEncoding
function matthews_corrcoef(target, output)
    @_dimcheck length(target) == length(output)
    tp = true_positives(target, output)
    tn = true_negatives(target, output)
    fp = false_positives(target, output)
    fn = false_negatives(target, output)
    numerator = (tp * tn) - (fp * fn)
    denominator = (tp + fp) * (tp + fn) * (tn + fp) * (tn + fn)
    return(numerator / (denominator ^ 0.5))
end
