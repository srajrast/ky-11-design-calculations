# KY-11 Design Calculations
This is a list of all of the MATLAB scripts used to perform calculations when designing the KY-11 WarGator

### Preliminary Sizing
**WeightEstimation.m**: Initial calculations of the maximum takeoff weight  
**Wing_Loading.m**: Initial calculations of wing loading at three conditions  
**Thrust2weight.m**: Initial calculations of T/W at three mission segments

### Aerodynamics
**LiftCoeffEstimation.m**: Lift coefficient calculations used for wing design

### Loads/Structures
**v-n-diagram.m**: Plot of the V-n diagram for the KY-11  
**WingboxStructure.m**: Initial calculations for determining wing structure

### Weights and C.G.
**RefinedWeightPt1.m**: Calculation of weights using Raymer's equations (15.1, 15.14-15.24)  
**RefinedWeightPt2.m**: Calculation of weights using Raymer's equations (15.2-15.13)  
**CGEnvelope.m**: Plot of the C.G. envelope and aircraft C.G. of possible cases  

### Stability
**AileronControlPower.m**: Calculation of the aileron control power and lateral static stability  
**DirectionalStabilityAndEngineOutCase.m**: Calculation of the directional static stability and trim analysis with engine out  
**DirectionalStabilityCrosswindsLandingCase.m**: Directional trim analysis for the crosswinds landing case  
**LongitudinalStaticStability.m**: Calculation of longitudinal static stability, neutral point, and static margin  
**TrimAnalysisLongitudinal.m**: Longitudinal trim analysis at takeoff, cruise, and landing

### Performance
**Endurance.m**: Endurance calculations  
**OperatingEnvelope.m**: Plot of the operating envelope  
**Range.m**: Range calculations  
**TakeoffAnalysis.m**: Takeoff distance calculations (Landing distance was calculated in a similar way)

## Cost Analysis
**CostEstimation.m**: Calculation of unit cost and maintenance costs





