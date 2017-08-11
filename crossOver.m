% Algorithm 5.3 Algorithm Cross-over
% Input: Two randomly selected MACA (MACA1 & MACA2) (For Scheme 1 MACA1 & MACA2 both should have 2m attractor)
% Output: Resultant MACA for NP
% Step 1: Randomly generate a number ‘q’ between 1 & n.
% Step 2: Take the first q symbols from MACA1 and the (n − q) symbols of MACA2. Form an MACA concatenating these symbols.
% Step 3: Make the necessary modifications of the MACA around the partition points to con- form with the pseudo-chromosome format ( Section 5.3.1) for the resulting MACA.
% Step 4: For Scheme 1, make necessary modifications in pseudo-chromosome format to en- sure that the number of attractors is 2m.