function components = componentsFcnQuadrat004()

% Function specifying default components

% Transistors
components(1) = makeComponent('XQ1', 'CPM2-1200-0160B', {0},{'N002', 'P001' 'N006' 'Tj'});
components(length(components)+1) = makeComponent('XQ2', 'CPM2-1200-0160B', {0},{'N003', 'P007' 'N007' 'Tj'});
components(length(components)+1) = makeComponent('XQ3', 'CPM2-1200-0160B', {0},{'N004', 'P008' 'N008' 'Tj'});
components(length(components)+1) = makeComponent('XQ4', 'CPM2-1200-0160B', {0},{'N005', 'P009' 'N009' 'Tj'});
% Diodes
components(length(components)+1) = makeComponent('D1', 'CPW41200S010B', {0}, {'P020', 'P006'});
components(length(components)+1) = makeComponent('D2', 'CPW41200S010B', {0}, {'P019', 'P005'});
components(length(components)+1) = makeComponent('D3', 'CPW41200S010B', {0}, {'P018', 'P004'});
components(length(components)+1) = makeComponent('D4', 'CPW41200S010B', {0}, {'P017', 'P003'});
% Gate resistances
components(length(components)+1) = makeComponent('Rg', '12', {0}, {'N018','N019'});
components(length(components)+1) = makeComponent('Rg1', '{Rg1}', {0}, {'P002','N010'});
components(length(components)+1) = makeComponent('Rg2', '{Rg1}', {0}, {'P010','N012'});
components(length(components)+1) = makeComponent('Rg3', '{Rg1}', {0}, {'P011','N014'});
components(length(components)+1) = makeComponent('Rg4', '{Rg1}', {0}, {'P012','N016'});
% Source resistances
components(length(components)+1) = makeComponent('RS1', '{RS}', {0}, {'P013','N011'});
components(length(components)+1) = makeComponent('RS2', '{RS}', {0}, {'P014','N013'});
components(length(components)+1) = makeComponent('RS3', '{RS}', {0}, {'P015','N015'});
components(length(components)+1) = makeComponent('RS4', '{RS}', {0}, {'P016','N017'});
% Parasitics
components(length(components)+1) = makeComponent('XU1', 'Quadraat', {0}, {'P003', 'P004', 'P005', 'P006', 'N022', 'NC_01', 'N006', 'NC_02', 'N007', 'NC_03', 'N008', 'NC_04', 'N009', 'N011', 'N013', 'N015', 'N017', 'P001', 'P007', 'P008', 'P009', 'P002', 'P010', 'P011', 'P012', 'N021', 'P013', 'P014', 'P015', 'P016', 'P017', 'P018', 'P019', 'P020', 'N002', 'N003', 'N004', 'N005', 'VDC', '0', 'N010', 'N012', 'N014', 'N016', 'N019', 'N020', 'N001'});

%Sources
components(length(components)+1) = makeComponent('V1', '650', {0}, {'VDC','0'});
components(length(components)+1) = makeComponent('I1', '40', {0}, {'0','N001'});
components(length(components)+1) = makeComponent('VG', 'PWL(0 -5 {ton} -5 {ton+1n} 20 {toff} 20 {toff+1n} -5 {tend} -5)', {0}, {'N018','N020'});
components(length(components)+1) = makeComponent('VTj', '25', {0}, {'Tj','0'});

components(length(components)+1) = makeComponent('Cout', '10p', {0}, {'0','N001'});

% Remove unused indices
components = components(all(~cellfun(@isempty,struct2cell(components))));
end

%N021 and N022 connection option!