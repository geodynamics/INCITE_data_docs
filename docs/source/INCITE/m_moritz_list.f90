      type(run_def), parameter :: moritz_runs(164) = (/                               &
     &  run_def(name = 'J-001', dir = 'mheimpel/JupNatGeo/E1n3/run1                       '), &
     &  run_def(name = 'J-002', dir = 'mheimpel/JupNatGeo/E1n3/run2                       '), &
     &  run_def(name = 'J-003', dir = 'mheimpel/JupNatGeo/E1n4/run1                       '), &
     &  run_def(name = 'J-004', dir = 'mheimpel/JupNatGeo/E1n4/run2                       '), &
     &  run_def(name = 'J-005', dir = 'mheimpel/JupNatGeo/E1n4/run3                       '), &
     &  run_def(name = 'J-006', dir = 'mheimpel/JupNatGeo/E1n5/run1                       '), &
     &  run_def(name = 'J-007', dir = 'mheimpel/JupNatGeo/E3n5/run1                       '), &
     &  run_def(name = 'J-008', dir = 'mheimpel/JupNatGeo/E3n6/run1                       '), &
     &  run_def(name = 'J-009', dir = 'mheimpel/JupNatGeo/E3n6/run2                       '), &
     &  run_def(name = 'J-010', dir = 'mheimpel/JupNatGeo/E3n6/run3                       '), &
     &  run_def(name = 'J-011', dir = 'mheimpel/JupNatGeo/E3n6/run4                       '), &
     &  run_def(name = 'J-012', dir = 'mheimpel/JupNatGeo/E3n6/run4a                      '), &
     &  run_def(name = 'J-013', dir = 'mheimpel/JupNatGeo/E3n6/run4b                      '), &
     &  run_def(name = 'J-014', dir = 'mheimpel/JupNatGeo/E3n6/run5                       '), &
     &  run_def(name = 'J-015', dir = 'mheimpel/JupNatGeo/E3n6/run6                       '), &
     &  run_def(name = 'J-016', dir = 'mheimpel/Jup90/fsb/E3n6/run1                       '), &
     &  run_def(name = 'J-017', dir = 'mheimpel/Jup90/fsb/E3n6/run2                       '), &
     &  run_def(name = 'J-018', dir = 'mheimpel/Jup90/fsb/E3n6/run3                       '), &
     &  run_def(name = 'J-019', dir = 'mheimpel/Jup90/fsb/E3n6/runM1                      '), &
     &  run_def(name = 'J-020', dir = 'mheimpel/Jup90/fsb/E3n6/runM2                      '), &
     &  run_def(name = 'J-021', dir = 'mheimpel/Jup90/fsb/E3n6/runM3                      '), &
     &  run_def(name = 'J-022', dir = 'mheimpel/Jup90/fsb/E3n6/runM4                      '), &
     &  run_def(name = 'J-023', dir = 'mheimpel/Jup90/fsb/E3n6/runM5                      '), &
     &  run_def(name = 'J-024', dir = 'mheimpel/Jup90/fsb/E3n6/runM6                      '), &
     &  run_def(name = 'J-025', dir = 'mheimpel/Jup90/nsb/E1n4/run1                       '), &
     &  run_def(name = 'J-026', dir = 'mheimpel/Jup90/nsb/E1n4/run2                       '), &
     &  run_def(name = 'J-027', dir = 'mheimpel/Jup90/nsb/E1n4/run3                       '), &
     &  run_def(name = 'J-028', dir = 'mheimpel/Jup90/nsb/E1n5/run1                       '), &
     &  run_def(name = 'J-029', dir = 'mheimpel/Jup90/nsb/E1n5/run2                       '), &
     &  run_def(name = 'J-030', dir = 'mheimpel/Jup90/nsb/E3n5/run1                       '), &
     &  run_def(name = 'J-031', dir = 'mheimpel/Jup90/nsb/E3n5/run2                       '), &
     &  run_def(name = 'J-032', dir = 'mheimpel/Jup90/nsb/E3n5/run3                       '), &
     &  run_def(name = 'J-033', dir = 'mheimpel/Jup90/nsb/E3n6/run1                       '), &
     &  run_def(name = 'J-034', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n4/run1               '), &
     &  run_def(name = 'J-035', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n4/run2               '), &
     &  run_def(name = 'J-036', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run1a              '), &
     &  run_def(name = 'J-037', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run1b              '), &
     &  run_def(name = 'J-038', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run1c              '), &
     &  run_def(name = 'J-039', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run2               '), &
     &  run_def(name = 'J-040', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run3               '), &
     &  run_def(name = 'J-041', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run4               '), &
     &  run_def(name = 'J-042', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run5               '), &
     &  run_def(name = 'J-043', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run6               '), &
     &  run_def(name = 'J-044', dir = 'mheimpel/Jup95/fsb/poly_n1/E1n5/run7               '), &
     &  run_def(name = 'J-045', dir = 'mheimpel/Jup95/fsb/poly_n1/E3n5/run1a              '), &
     &  run_def(name = 'J-046', dir = 'mheimpel/Jup95/fsb/poly_n1/E3n5/run1b              '), &
     &  run_def(name = 'J-047', dir = 'mheimpel/Jup95/fsb/poly_n1/E3n5/run1c              '), &
     &  run_def(name = 'J-048', dir = 'mheimpel/Jup95/fsb/poly_n1/E3n6/run1a              '), &
     &  run_def(name = 'J-049', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n5/run1               '), &
     &  run_def(name = 'J-050', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n5/run2               '), &
     &  run_def(name = 'J-051', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n5/run3               '), &
     &  run_def(name = 'J-052', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n5/run4               '), &
     &  run_def(name = 'J-053', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/run1a              '), &
     &  run_def(name = 'J-054', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/run1b              '), &
     &  run_def(name = 'J-055', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/run1c              '), &
     &  run_def(name = 'J-056', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/run1d              '), &
     &  run_def(name = 'J-057', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/run2               '), &
     &  run_def(name = 'J-058', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/run3               '), &
     &  run_def(name = 'J-059', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/run4               '), &
     &  run_def(name = 'J-060', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/runM1              '), &
     &  run_def(name = 'J-061', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/runM2              '), &
     &  run_def(name = 'J-062', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/runM3              '), &
     &  run_def(name = 'J-063', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/runM4              '), &
     &  run_def(name = 'J-064', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/runM5              '), &
     &  run_def(name = 'J-065', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/runM6              '), &
     &  run_def(name = 'J-066', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/runM7              '), &
     &  run_def(name = 'J-067', dir = 'mheimpel/Jup95/nsb/poly_n1/E2n6/run1               '), &
     &  run_def(name = 'J-068', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n5/run1               '), &
     &  run_def(name = 'J-069', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n5/run2               '), &
     &  run_def(name = 'J-070', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n5/run3               '), &
     &  run_def(name = 'J-071', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n5/run4               '), &
     &  run_def(name = 'J-072', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n5/run5               '), &
     &  run_def(name = 'J-073', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n5/run6               '), &
     &  run_def(name = 'J-074', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n5/run7               '), &
     &  run_def(name = 'J-075', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n5/run8               '), &
     &  run_def(name = 'J-076', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/run1               '), &
     &  run_def(name = 'J-077', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/run2               '), &
     &  run_def(name = 'J-078', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/run3               '), &
     &  run_def(name = 'J-079', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/run4               '), &
     &  run_def(name = 'J-080', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/run5               '), &
     &  run_def(name = 'J-081', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/run6               '), &
     &  run_def(name = 'J-082', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/run7               '), &
     &  run_def(name = 'J-083', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/run8               '), &
     &  run_def(name = 'J-084', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/runM1              '), &
     &  run_def(name = 'J-085', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n7/run1a              '), &
     &  run_def(name = 'J-086', dir = 'mheimpel/Jup95/nsb/poly_n2/E1n5/run1               '), &
     &  run_def(name = 'J-087', dir = 'mheimpel/Jup95/nsb/poly_n2/E1n5/run2               '), &
     &  run_def(name = 'J-088', dir = 'mheimpel/Jup95/nsb/poly_n2/E3n5/run1               '), &
     &  run_def(name = 'J-089', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n4/run1 '), &
     &  run_def(name = 'J-090', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n4/run2 '), &
     &  run_def(name = 'J-091', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n4/run3 '), &
     &  run_def(name = 'J-092', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run01'), &
     &  run_def(name = 'J-093', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run02'), &
     &  run_def(name = 'J-094', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run03'), &
     &  run_def(name = 'J-095', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run04'), &
     &  run_def(name = 'J-096', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n5/run1 '), &
     &  run_def(name = 'J-097', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/run01'), &
     &  run_def(name = 'J-098', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/run02'), &
     &  run_def(name = 'J-099', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/runR1'), &
     &  run_def(name = 'J-100', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/runR2'), &
     &  run_def(name = 'J-101', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/runR3'), &
     &  run_def(name = 'J-102', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E1n6/runR4'), &
     &  run_def(name = 'J-103', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n4/run1 '), &
     &  run_def(name = 'J-104', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n4/run2 '), &
     &  run_def(name = 'J-105', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n4/run3 '), &
     &  run_def(name = 'J-106', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run1 '), &
     &  run_def(name = 'J-107', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run2 '), &
     &  run_def(name = 'J-108', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run3 '), &
     &  run_def(name = 'J-109', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run4 '), &
     &  run_def(name = 'J-110', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run5 '), &
     &  run_def(name = 'J-111', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run6 '), &
     &  run_def(name = 'J-112', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n5/run7 '), &
     &  run_def(name = 'J-113', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run01'), &
     &  run_def(name = 'J-114', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run02'), &
     &  run_def(name = 'J-115', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run03'), &
     &  run_def(name = 'J-116', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run04'), &
     &  run_def(name = 'J-117', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run05'), &
     &  run_def(name = 'J-118', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run1 '), &
     &  run_def(name = 'J-119', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run2 '), &
     &  run_def(name = 'J-120', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run3 '), &
     &  run_def(name = 'J-121', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run4 '), &
     &  run_def(name = 'J-122', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run5 '), &
     &  run_def(name = 'J-123', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/run6 '), &
     &  run_def(name = 'J-124', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/runM7'), &
     &  run_def(name = 'J-125', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type1/E3n6/runM8'), &
     &  run_def(name = 'J-126', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n4/run1 '), &
     &  run_def(name = 'J-127', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n4/run2 '), &
     &  run_def(name = 'J-128', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n5/run1a'), &
     &  run_def(name = 'J-129', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n5/run1b'), &
     &  run_def(name = 'J-130', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E1n5/run2 '), &
     &  run_def(name = 'J-131', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E3n4/run1 '), &
     &  run_def(name = 'J-132', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E3n4/run1a'), &
     &  run_def(name = 'J-133', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E3n5/run1a'), &
     &  run_def(name = 'J-134', dir = 'mheimpel/Jup95/fsb/poly_n2/heating_type4/E3n5/run1b'), &
     &  run_def(name = 'J-135', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n5/10xRa/run1         '), &
     &  run_def(name = 'J-136', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n5/10xRa/run2         '), &
     &  run_def(name = 'J-137', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n5/10xRa/runM1        '), &
     &  run_def(name = 'J-138', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/run1          '), &
     &  run_def(name = 'J-139', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/run2          '), &
     &  run_def(name = 'J-140', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/runM1         '), &
     &  run_def(name = 'J-141', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/runM2         '), &
     &  run_def(name = 'J-142', dir = 'mheimpel/Jup95/nsb/poly_n1/E1n6/4xRa/runM3         '), &
     &  run_def(name = 'J-143', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/run1         '), &
     &  run_def(name = 'J-144', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM1        '), &
     &  run_def(name = 'J-145', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM10       '), &
     &  run_def(name = 'J-146', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM2        '), &
     &  run_def(name = 'J-147', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM3        '), &
     &  run_def(name = 'J-148', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM4        '), &
     &  run_def(name = 'J-149', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM5        '), &
     &  run_def(name = 'J-150', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM6        '), &
     &  run_def(name = 'J-151', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM7        '), &
     &  run_def(name = 'J-152', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM8        '), &
     &  run_def(name = 'J-153', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/10xRa/runM9        '), &
     &  run_def(name = 'J-154', dir = 'mheimpel/Jup95/nsb/poly_n1/E3n6/Prp3/run1          '), &
     &  run_def(name = 'U-001', dir = 'mheimpel/Uranus75/E1n3/run1                        '), &
     &  run_def(name = 'U-002', dir = 'mheimpel/Uranus75/E1n4/run1                        '), &
     &  run_def(name = 'U-003', dir = 'mheimpel/Uranus75/E3n4/run1                        '), &
     &  run_def(name = 'U-004', dir = 'mheimpel/Uranus75/E3n4/run2                        '), &
     &  run_def(name = 'U-005', dir = 'mheimpel/Uranus75/E3n4/run3                        '), &
     &  run_def(name = 'U-006', dir = 'mheimpel/Uranus75/E3n4/run4                        '), &
     &  run_def(name = 'U-007', dir = 'mheimpel/Uranus75/N5/E1n3/run1                     '), &
     &  run_def(name = 'U-008', dir = 'mheimpel/Uranus75/N5/E1n3/run2                     '), &
     &  run_def(name = 'U-009', dir = 'mheimpel/Uranus75/N5/E1n4/run1                     '), &
     &  run_def(name = 'U-010', dir = 'mheimpel/Uranus75/N5/E3n4/run1                     ')/)
