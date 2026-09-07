# Cross-Asset Quant Lakehouse

Databricks research lakehouse for U.S. rates, FX, and energy commodities.
Bronze/Silver/Gold Delta tables with point-in-time alignment, distribution
diagnostics, benchmark models, and robustness testing.

## Objective
(to be written)

## Research rules
1. No future information may be used before its `available_at` timestamp.
2. A benchmark model is never described as the true return-generating process.
3. Returns are not assumed normal or lognormal; empirical distributions are tested.
4. Raw source values are immutable; every transformation is traceable.
5. Failed hypotheses and unstable relationships are recorded, not deleted.
6. Yield changes are not converted into bond returns without an explicit pricing method.
7. A policy-rate differential is labeled a carry proxy, not an executable FX carry return, unless forwards and financing are modeled.

## Architecture
(to be written)

## Data sources and availability rules
(to be written)

## Research questions
(to be written)

## Methods and diagnostics
(to be written)

## Results
(to be written)

## Robustness and failures
(to be written)

## Limitations
(to be written)

## How to reproduce
(to be written)
