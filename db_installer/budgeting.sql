-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql.s3platform.eu
-- Generation Time: Nov 26, 2018 at 03:19 AM
-- Server version: 5.6.34-log
-- PHP Version: 7.1.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `budgetingdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

CREATE TABLE `budget` (
  `id` bigint(20) NOT NULL,
  `measure` bigint(20) DEFAULT NULL,
  `programme` varchar(255) DEFAULT NULL,
  `object` varchar(2) CHARACTER SET latin1 DEFAULT NULL,
  `inter` varchar(3) CHARACTER SET latin1 DEFAULT NULL,
  `finance` varchar(2) CHARACTER SET latin1 DEFAULT NULL,
  `funding` int(11) DEFAULT NULL,
  `budget_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `budget_plan`
--

CREATE TABLE `budget_plan` (
  `plan_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `region_id` varchar(10) DEFAULT NULL,
  `published` smallint(2) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `budget_val`
--

CREATE TABLE `budget_val` (
  `budget_id` bigint(20) NOT NULL,
  `year` varchar(10) CHARACTER SET latin1 NOT NULL,
  `planned` float DEFAULT NULL,
  `commit` float DEFAULT NULL,
  `spent` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `finance`
--

CREATE TABLE `finance` (
  `id` varchar(2) CHARACTER SET latin1 NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `finance`
--

INSERT INTO `finance` (`id`, `description`) VALUES
('01', 'Non-repayable grant '),
('02', 'Repayable grant'),
('03', 'Support through financial instruments: venture and equity capital or equivalent'),
('04', 'Support through financial instruments: loan or equivalent'),
('05', 'Support through financial instruments: guarantee or equivalent'),
('06', 'Support through financial instruments: interest rate subsidy'),
('07', 'Prize');

-- --------------------------------------------------------

--
-- Table structure for table `funding`
--

CREATE TABLE `funding` (
  `id` int(11) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `funding`
--

INSERT INTO `funding` (`id`, `description`) VALUES
(1, 'Private (business) contribution'),
(2, 'National public funds'),
(3, 'Regional public funds'),
(4, 'Charitable or other national/regional sources'),
(5, 'ERDF: European Regional Development Fund'),
(6, 'ESF: European Social Fund'),
(7, 'EAFRD: European Agricultural Fund for Rural Development'),
(8, 'EMFF: European Maritime and Fisheries Fund'),
(9, 'European Fund for Strategic Investments (EFSI)'),
(10, 'Research Framework Programme (currently Horizon 2020) – potentially broken down by sub-programme'),
(11, 'European Institute of Innovation and Technology (EIT) - Knowledge and Innovation Communities (KIC)'),
(12, 'European Innovation Partnerships'),
(13, 'Connecting Europe Facility (CEF)'),
(14, 'Competitiveness of Enterprises and Small and Medium-sized Enterprises (COSME)'),
(15, 'LIFE'),
(16, 'Creative Europe'),
(17, 'Employment and Social Innovation (EaSI) programme'),
(18, 'Erasmus+'),
(19, 'Third EU Health programme');

-- --------------------------------------------------------

--
-- Table structure for table `inter`
--

CREATE TABLE `inter` (
  `id` varchar(3) CHARACTER SET latin1 NOT NULL,
  `type` int(11) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `inter`
--

INSERT INTO `inter` (`id`, `type`, `description`) VALUES
('001', 1, 'Generic productive investment in small and medium - sized enterprises (SMEs)'),
('002', 1, 'Research and innovation processes in large enterprises'),
('003', 1, 'Productive investment in large enterprises linked to the low-carbon economy'),
('004', 1, 'Productive investment linked to the cooperation between large enterprises and SMEs for developing information and communication technology (ICT) products and services, e-commerce and enhancing demand for ICT'),
('005', 2, 'Electricity (storage and transmission)'),
('006', 2, 'Electricity (TEN-E storage and transmission)'),
('007', 2, 'Natural gas'),
('008', 2, 'Natural gas (TEN-E)'),
('009', 2, 'Renewable energy: wind'),
('010', 2, 'Renewable energy: solar'),
('011', 2, 'Renewable energy: biomass'),
('012', 2, 'Other renewable energy (including hydroelectric, geothermal and marine energy) and renewable energy inte­ gration (including storage, power to gas and renewable hydrogen infrastructure)'),
('013', 2, 'Energy efficiency renovation of public infrastructure, demonstration projects and supporting measures'),
('014', 2, 'Energy efficiency renovation of existing housing stock, demonstration projects and supporting measures'),
('015', 2, 'Intelligent Energy Distribution Systems at medium and low voltage levels (including smart grids and ICT systems)'),
('016', 2, 'High efficiency co-generation and district heating'),
('017', 2, 'Household waste management, (including minimisation, sorting, recycling measures)'),
('018', 2, 'Household waste management, (including mechanical biological treatment, thermal treatment, incineration and landfill measures)'),
('019', 2, 'Commercial, industrial or hazardous waste management'),
('020', 2, 'Provision of water for human consumption (extraction, treatment, storage and distribution infrastructure)'),
('021', 2, 'Water management and drinking water conservation (including river basin management, water supply, specific climate change adaptation measures, district and consumer metering, charging systems and leak reduction)'),
('022', 2, 'Waste water treatment'),
('023', 2, 'Environmental measures aimed at reducing and/or avoiding greenhouse gas emissions (including treatment and storage of methane gas and composting)'),
('024', 2, 'Railways (TEN-T Core)'),
('025', 2, 'Railways (TEN-T comprehensive)'),
('026', 2, 'Other Railways'),
('027', 2, 'Mobile rail assets'),
('028', 2, 'TEN-T motorways and roads - core network (new build)'),
('029', 2, 'TEN-T motorways and roads - comprehensive network (new build)'),
('030', 2, 'Secondary road links to TEN-T road network and nodes (new build)'),
('031', 2, 'Other national and regional roads (new build)'),
('032', 2, 'Local access roads (new build)'),
('033', 2, 'TEN-T reconstructed or improved road'),
('034', 2, 'Other reconstructed or improved road (motorway, national, regional or local)'),
('035', 2, 'Multimodal transport (TEN-T)'),
('036', 2, 'Multimodal transport'),
('037', 2, 'Airports (TEN-T) (1)'),
('038', 2, 'Other airports (1)'),
('039', 2, 'Seaports (TEN-T)'),
('040', 2, 'Other seaports'),
('041', 2, 'Inland waterways and ports (TEN-T)'),
('042', 2, 'Inland waterways and ports (regional and local)'),
('043', 2, 'Clean urban transport infrastructure and promotion (including equipment and rolling stock)'),
('044', 2, 'Intelligent transport systems (including the introduction of demand management, tolling systems, IT moni­ toring, control and information systems)'),
('045', 2, 'ICT: Backbone/backhaul network'),
('046', 2, 'ICT: High-speed broadband network (access/local loop; >/= 30 Mbps)'),
('047', 2, 'ICT: Very high-speed broadband network (access/local loop; >/= 100 Mbps)'),
('048', 2, 'ICT: Other types of ICT infrastructure/large-scale computer resources/equipment (including e-infrastructure, data centres and sensors; also where embedded in other infrastructure such as research facilities, environmental and social infrastructure)'),
('049', 3, 'Education infrastructure for tertiary education'),
('050', 3, 'Education infrastructure for vocational education and training and adult learning'),
('051', 3, 'Education infrastructure for school education (primary and general secondary education)'),
('052', 3, 'Infrastructure for early childhood education and care'),
('053', 3, 'Health infrastructure'),
('054', 3, 'Housing infrastructure'),
('055', 3, 'Other social infrastructure contributing to regional and local development'),
('056', 4, 'Investment in infrastructure, capacities and equipment in SMEs directly linked to research and innovation activities'),
('057', 4, 'Investment in infrastructure, capacities and equipment in large companies directly linked to research and innovation activities'),
('058', 4, 'Research and innovation infrastructure (public)'),
('059', 4, 'Research and innovation infrastructure (private, including science parks)'),
('060', 4, 'Research and innovation activities in public research centres and centres of competence including networking'),
('061', 4, 'Research and innovation activities in private research centres including networking'),
('062', 4, 'Technology transfer and university-enterprise cooperation primarily benefiting SMEs'),
('063', 4, 'Cluster support and business networks primarily benefiting SMEs'),
('064', 4, 'Research and innovation processes in SMEs (including voucher schemes, process, design, service and social innovation)'),
('065', 4, 'Research and innovation infrastructure, processes, technology transfer and cooperation in enterprises focusing on the low carbon economy and on resilience to climate change'),
('066', 4, 'Advanced support services for SMEs and groups of SMEs (including management, marketing and design services)'),
('067', 4, 'SME business development, support to entrepreneurship and incubation (including support to spin offs and spin outs)'),
('068', 4, 'Energy efficiency and demonstration projects in SMEs and supporting measures'),
('069', 4, 'Support to environmentally-friendly production processes and resource efficiency in SMEs'),
('070', 4, 'Promotion of energy efficiency in large enterprises'),
('071', 4, 'Development and promotion of enterprises specialised in providing services contributing to the low carbon economy and to resilience to climate change (including support to such services)'),
('072', 4, 'Business infrastructure for SMEs (including industrial parks and sites)'),
('073', 4, 'Support to social enterprises (SMEs)'),
('074', 4, 'Development and promotion of tourism assets in SMEs'),
('075', 4, 'Development and promotion of tourism services in or for SMEs'),
('076', 4, 'Development and promotion of cultural and creative assets in SMEs'),
('077', 4, 'Development and promotion of cultural and creative services in or for SMEs'),
('078', 4, 'e-Government services and applications (including e-Procurement, ICT measures supporting the reform of public administration, cyber-security, trust and privacy measures, e-Justice and e-Democracy)'),
('079', 4, 'Access to public sector information (including open data e-Culture, digital libraries, e-Content and e-Tourism)'),
('080', 4, 'e-Inclusion, e-Accessibility, e-Learning and e-Education services and applications, digital literacy'),
('081', 4, 'ICT solutions addressing the healthy active ageing challenge and e-Health services and applications (including e-Care and ambient assisted living)'),
('082', 4, 'ICT Services and applications for SMEs (including e-Commerce, e-Business and networked business processes), living labs, web entrepreneurs and ICT start-ups)'),
('083', 4, 'Air quality measures'),
('084', 4, 'Integrated pollution prevention and control (IPPC)'),
('085', 4, 'Protection and enhancement of biodiversity, nature protection and green infrastructure'),
('086', 4, 'Protection, restoration and sustainable use of Natura 2000 sites'),
('087', 4, 'Adaptation to climate change measures and prevention and management of climate related risks e.g. erosion, fires, flooding, storms and drought, including awareness raising, civil protection and disaster management systems and infrastructures'),
('088', 4, 'Risk prevention and management of non-climate related natural risks (i.e. earthquakes) and risks linked to human activities (e.g. technological accidents), including awareness raising, civil protection and disaster management systems and infrastructures'),
('089', 4, 'Rehabilitation of industrial sites and contaminated land'),
('090', 4, 'Cycle tracks and footpaths'),
('091', 4, 'Development and promotion of the tourism potential of natural areas'),
('092', 4, 'Protection, development and promotion of public tourism assets'),
('093', 4, 'Development and promotion of public tourism services'),
('094', 4, 'Protection, development and promotion of public cultural and heritage assets'),
('095', 4, 'Development and promotion of public cultural and heritage services'),
('096', 4, 'Institutional capacity of public administrations and public services related to implementation of the ERDF or actions supporting ESF institutional capacity initiatives'),
('097', 4, 'Community-led local development initiatives in urban and rural areas'),
('098', 4, 'Outermost regions: compensation of any additional costs due to accessibility deficit and territorial fragmen­ tation'),
('099', 4, 'Outermost regions: specific action to compensate additional costs due to size market factors'),
('100', 4, 'Outermost regions: support to compensate additional costs due to climate conditions and relief difficulties'),
('101', 4, 'Cross-financing under the ERDF (support to ESF-type actions necessary for the satisfactory implementation of the ERDF part of the operation and directly linked to it)'),
('102', 5, 'Access to employment for job-seekers and inactive people, including the long-term unemployed and people far from the labour market, also through local employment initiatives and support for labour mobility'),
('103', 5, 'Sustainable integration into the labour market of young people, in particular those not in employment, education or training, including young people at risk of social exclusion and young people from marginalised communities, including through the implementation of the Youth Guarantee'),
('104', 5, 'Self-employment, entrepreneurship and business creation including innovative micro, small and medium sized enterprises'),
('105', 5, 'Equality between men and women in all areas, including in access to employment, career progression, reconciliation of work and private life and promotion of equal pay for equal work'),
('106', 5, 'Adaptation of workers, enterprises and entrepreneurs to change'),
('107', 5, 'Active and healthy ageing'),
('108', 5, 'Modernisation of labour market institutions, such as public and private employment services, and improving the matching of labour market needs, including throughactions that enhance transnational labour mobility as well as through mobility schemes and better cooperation between institutions and relevant stakeholders'),
('109', 6, 'Active inclusion, including with a view to promoting equal opportunities and active participation, and improving employability'),
('110', 6, 'Socio-economic integration of marginalised communities such as the Roma'),
('111', 6, 'Combating all forms of discrimination and promoting equal opportunities'),
('112', 6, 'Enhancing access to affordable, sustainable and high-quality services, including health care and social services of general interest'),
('113', 6, 'Promoting social entrepreneurship and vocational integration in social enterprises and the social and solidarity economy in order to facilitate access to employment'),
('114', 6, 'Community-led local development strategies'),
('115', 7, 'Reducing and preventing early school-leaving and promoting equal access to good quality early-childhood, primary and secondary education including formal, non-formal and informal learning pathways for reinte­ grating into education and training'),
('116', 7, 'Improving the quality and efficiency of, and access to, tertiary and equivalent education with a view to increasing participation and attainment levels, especially for disadvantaged groups'),
('117', 7, 'Enhancing equal access to lifelong learning for all age groups in formal, non-formal and informal settings, upgrading the knowledge, skills and competences of the workforce, and promoting flexible learning pathways including through career guidance and validation of acquired competences'),
('118', 7, 'Improving the labour market relevance of education and training systems, facilitating the transition from education to work, and strengthening vocational education and training systems and their quality, including through mechanisms for skills anticipation, adaptation of curricula and the establishment and development of work-based learning systems, including dual learning systems and apprenticeship schemes'),
('119', 8, 'Investment in institutional capacity and in the efficiency of public administrations and public services at the national, regional and local levels with a view to reforms, better regulation and good governance'),
('120', 8, 'Capacity building for all stakeholders delivering education, lifelong learning, training and employment and social policies, including through sectoral and territorial pacts to mobilise for reform at the national, regional and local levels'),
('121', 9, 'Preparation, implementation, monitoring and inspection'),
('122', 9, 'Evaluation and studies'),
('123', 9, 'Information and communication');

-- --------------------------------------------------------

--
-- Table structure for table `inter_types`
--

CREATE TABLE `inter_types` (
  `id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `inter_types`
--

INSERT INTO `inter_types` (`id`, `description`) VALUES
(1, 'Productive investment'),
(2, 'Infrastructure providing basic services and related investment'),
(3, 'Social'),
(4, 'Development of endogenous potential'),
(5, 'Promoting sustainable and quality employment and supporting labour mobility'),
(6, 'Promoting social inclusion'),
(7, 'Investing in education'),
(8, 'Enhancing institutional capacity of public authorities and stakeholders and efficient public administration'),
(9, 'Technical assistance');

-- --------------------------------------------------------

--
-- Table structure for table `measure`
--

CREATE TABLE `measure` (
  `id` bigint(20) NOT NULL,
  `prio_id` bigint(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `measure_order` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `nuts0`
--

CREATE TABLE `nuts0` (
  `code` varchar(2) NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuts0`
--

INSERT INTO `nuts0` (`code`, `label`) VALUES
('AT', 'Austria'),
('BE', 'Belgium'),
('BG', 'Bulgaria'),
('HR', 'Croatia'),
('CY', 'Cyprus'),
('CZ', 'Czech Republic'),
('DK', 'Denmark'),
('EE', 'Estonia'),
('FI', 'Finland'),
('FR', 'France'),
('DE', 'Germany'),
('EL', 'Greece'),
('HU', 'Hungary'),
('IE', 'Ireland'),
('IT', 'Italy'),
('LV', 'Latvia'),
('LT', 'Lithuania'),
('LU', 'Luxembourg'),
('MT', 'Malta'),
('NL', 'Netherlands'),
('PL', 'Poland'),
('PT', 'Portugal'),
('RO', 'Romania'),
('SK', 'Slovakia'),
('SI', 'Slovenia'),
('ES', 'Spain'),
('SE', 'Sweden'),
('UK', 'United Kingdom');

-- --------------------------------------------------------

--
-- Table structure for table `nuts1`
--

CREATE TABLE `nuts1` (
  `country_id` varchar(2) NOT NULL,
  `code` varchar(3) NOT NULL,
  `label` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `nuts1`
--

INSERT INTO `nuts1` (`country_id`, `code`, `label`) VALUES
('AT', 'AT1', 'East Austria'),
('AT', 'AT2', 'South Austria'),
('AT', 'AT3', 'West Austria'),
('BE', 'BE1', 'Brussels Capital Region'),
('BE', 'BE2', 'Flemish Region'),
('BE', 'BE3', 'Walloon Region'),
('BG', 'BG3', 'Northern and Eastern Bulgaria'),
('BG', 'BG4', 'South-Western and South-Central Bulgaria'),
('CY', 'CY0', 'Cyprus'),
('CZ', 'CZ0', 'Czech Republic'),
('DE', 'DE1', 'Baden-Württemberg'),
('DE', 'DE2', 'Bavaria'),
('DE', 'DE3', 'Berlin'),
('DE', 'DE4', 'Brandenburg'),
('DE', 'DE5', 'Free Hanseatic City of Bremen'),
('DE', 'DE6', 'Hamburg'),
('DE', 'DE7', 'Hessen'),
('DE', 'DE8', 'Mecklenburg-Vorpommern'),
('DE', 'DE9', 'Lower Saxony'),
('DE', 'DEA', 'North Rhine-Westphalia'),
('DE', 'DEB', 'Rhineland-Palatinate'),
('DE', 'DEC', 'Saarland'),
('DE', 'DED', 'Saxony'),
('DE', 'DEE', 'Saxony-Anhalt'),
('DE', 'DEF', 'Schleswig-Holstein'),
('DE', 'DEG', 'Thuringia'),
('DK', 'DK0', 'Denmark'),
('EE', 'EE0', 'Estonia'),
('EL', 'EL3', 'Attica'),
('EL', 'EL4', 'Nisia Aigaiou, Kriti'),
('EL', 'EL5', 'Voreia Ellada'),
('EL', 'EL6', 'Kentriki Ellada'),
('ES', 'ES1', 'North West'),
('ES', 'ES2', 'North East'),
('ES', 'ES3', 'Community of Madrid'),
('ES', 'ES4', 'Centre'),
('ES', 'ES5', 'East'),
('ES', 'ES6', 'South'),
('ES', 'ES7', 'Canary Islands'),
('FI', 'FI1', 'Mainland Finland'),
('FI', 'FI2', 'Åland'),
('FR', 'FR1', 'Région parisienne '),
('FR', 'FR2', 'Bassin parisien'),
('FR', 'FR3', 'Nord'),
('FR', 'FR4', 'Est'),
('FR', 'FR5', 'Ouest'),
('FR', 'FR6', 'Sud-Ouest'),
('FR', 'FR7', 'Centre-Est'),
('FR', 'FR8', 'Méditerranée'),
('FR', 'FRA', 'Départements d\"Outre-Mer'),
('HR', 'HR0', 'Croatia'),
('HR', 'HU1', 'Central Hungary'),
('HR', 'HU2', 'Transdanubia'),
('HR', 'HU3', 'Great Plain and North'),
('IE', 'IE0', 'Ireland'),
('IT', 'ITC', 'North West'),
('IT', 'ITF', 'South'),
('IT', 'ITG', 'Islands'),
('IT', 'ITH', 'North East'),
('IT', 'ITI', 'Centre'),
('LT', 'LT0', 'Lithuania'),
('LU', 'LU0', 'Luxembourg'),
('LV', 'LV0', 'Latvia'),
('MT', 'MT0', 'Malta'),
('NL', 'NL1', 'North Netherlands'),
('NL', 'NL2', 'East Netherlands'),
('NL', 'NL3', 'West Netherlands'),
('NL', 'NL4', 'South Netherlands'),
('PL', 'PL1', 'Central Region'),
('PL', 'PL2', 'South Region'),
('PL', 'PL3', 'East Region'),
('PL', 'PL4', 'Northwest Region'),
('PL', 'PL5', 'Southwest Region'),
('PL', 'PL6', 'North Region'),
('PT', 'PT1', 'Mainland Portugal'),
('PT', 'PT2', 'Azores'),
('PT', 'PT3', 'Madeira'),
('RO', 'RO1', 'One'),
('RO', 'RO2', 'Two'),
('RO', 'RO3', 'Three'),
('RO', 'RO4', 'Four'),
('SE', 'SE1', 'East Sweden'),
('SE', 'SE2', 'South Sweden'),
('SE', 'SE3', 'North Sweden'),
('SK', 'SK0', 'Slovenia'),
('UK', 'UKC', 'North East'),
('UK', 'UKD', 'North West'),
('UK', 'UKE', 'Yorkshire and the Humber'),
('UK', 'UKF', 'East Midlands'),
('UK', 'UKG', 'West Midlands'),
('UK', 'UKH', 'East of England'),
('UK', 'UKI', 'Greater London'),
('UK', 'UKJ', 'South East'),
('UK', 'UKK', 'South West'),
('UK', 'UKL', 'Wales'),
('UK', 'UKM', 'Scotland'),
('UK', 'UKN', 'Northern Ireland');

-- --------------------------------------------------------

--
-- Table structure for table `objective`
--

CREATE TABLE `objective` (
  `id` varchar(2) CHARACTER SET latin1 NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `objective`
--

INSERT INTO `objective` (`id`, `description`) VALUES
('01', 'Strengthening research'),
('02', 'Enhancing access to'),
('03', 'Enhancing the competitiveness of small and medium-sized enterprises'),
('04', 'Supporting the shift towards a low-carbon economy in all sectors'),
('05', 'Promoting climate change adaptation'),
('06', 'Preserving and protecting the environment and promoting resource efficiency'),
('07', 'Promoting sustainable transport and removing bottlenecks in key network infrastructures '),
('08', 'Promoting sustainable and quality employment and supporting labour mobility'),
('09', 'Promoting social inclusion and combating poverty and any discrimination '),
('10', 'Investing in education'),
('11', 'Enhancing the institutional capacity of public authorities and stakeholders and an efficient public '),
('12', 'Not applicable (Technical assistance only) ');

-- --------------------------------------------------------

--
-- Table structure for table `priority`
--

CREATE TABLE `priority` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `comment` text,
  `creation_dt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `prio_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prio_years`
--

CREATE TABLE `prio_years` (
  `year` varchar(10) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `region`
--

CREATE TABLE `region` (
  `code` varchar(4) NOT NULL,
  `label` varchar(255) NOT NULL,
  `ind` smallint(6) NOT NULL,
  `nuts_label` varchar(255) NOT NULL,
  `nuts_level` int(11) NOT NULL,
  `country_id` varchar(2) NOT NULL,
  `rg_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `region`
--

INSERT INTO `region` (`code`, `label`, `ind`, `nuts_label`, `nuts_level`, `country_id`, `rg_order`) VALUES
('AT11', 'Burgenland (A)', 0, 'Burgenland (AT)', 2, 'AT', 1261),
('AT12', 'Niederösterreich', 0, 'Niederösterreich', 2, 'AT', 1265),
('AT13', 'Wien', 0, 'Wien', 2, 'AT', 1273),
('AT21', 'Kärnten', 0, 'Kärnten', 2, 'AT', 1276),
('AT22', 'Steiermark', 0, 'Steiermark', 2, 'AT', 1280),
('AT31', 'Oberösterreich', 0, 'Oberösterreich', 2, 'AT', 1288),
('AT32', 'Salzburg', 0, 'Salzburg', 2, 'AT', 1294),
('AT33', 'Tirol', 0, 'Tirol', 2, 'AT', 1298),
('AT34', 'Vorarlberg', 0, 'Vorarlberg', 2, 'AT', 1304),
('BE10', 'Région de Bruxelles-Capitale / Brussels Hoofdstedelijk Gewest', 0, 'Région de Bruxelles-Capitale/Brussels Hoofdstedelijk Gewest', 2, 'BE', 3),
('BE21', 'Prov. Antwerpen', 0, 'Prov. Antwerpen', 2, 'BE', 6),
('BE22', 'Prov.Limburg (B)', 0, 'Prov. Limburg (BE)', 2, 'BE', 10),
('BE23', 'Prov. Oost-Vlaanderen', 0, 'Prov. Oost-Vlaanderen', 2, 'BE', 14),
('BE24', 'Prov. Vlaams-Brabant', 0, 'Prov. Vlaams-Brabant', 2, 'BE', 21),
('BE25', 'Prov. West-Vlaanderen', 0, 'Prov. West-Vlaanderen', 2, 'BE', 24),
('BE31', 'Prov. Brabant Wallon', 0, 'Prov. Brabant Wallon', 2, 'BE', 34),
('BE32', 'Prov. Hainaut', 0, 'Prov. Hainaut', 2, 'BE', 36),
('BE33', 'Prov.Liège', 0, 'Prov. Liège', 2, 'BE', 44),
('BE34', 'Prov.Luxembourg (B)', 0, 'Prov. Luxembourg (BE)', 2, 'BE', 50),
('BE35', 'Prov. Namur', 0, 'Prov. Namur', 2, 'BE', 56),
('BG31', 'Severozapaden', 0, 'Северозападен (Severozapaden)', 2, 'BG', 65),
('BG32', 'Severen tsentralen', 0, 'Северен централен (Severen tsentralen)', 2, 'BG', 71),
('BG33', 'Severoiztochen', 0, 'Североизточен (Severoiztochen)', 2, 'BG', 77),
('BG34', 'Yugoiztochen', 0, 'Югоизточен (Yugoiztochen)', 2, 'BG', 82),
('BG41', 'Yugozapaden', 0, 'Югозападен (Yugozapaden)', 2, 'BG', 88),
('BG42', 'Yuzhen tsentralen', 0, 'Южен централен (Yuzhen tsentralen)', 2, 'BG', 94),
('CY00', 'Kypros / Kibris', 0, 'Κύπρος (Kýpros)', 2, 'CY', 1117),
('CZ01', 'Praha', 0, 'Praha', 2, 'CZ', 105),
('CZ02', 'Stredni Cechy', 0, 'Střední Čechy', 2, 'CZ', 107),
('CZ03', 'Jihozapad', 0, 'Jihozápad', 2, 'CZ', 109),
('CZ04', 'Severozapad', 0, 'Severozápad', 2, 'CZ', 112),
('CZ05', 'Severovychod', 0, 'Severovýchod', 2, 'CZ', 115),
('CZ06', 'Jihovychod', 0, 'Jihovýchod', 2, 'CZ', 119),
('CZ07', 'Stredni Morava', 0, 'Střední Morava', 2, 'CZ', 122),
('CZ08', 'Moravskoslezsko', 0, 'Moravskoslezsko', 2, 'CZ', 125),
('DE11', 'Stuttgart', 0, 'Stuttgart', 2, 'DE', 153),
('DE12', 'Karlsruhe', 0, 'Karlsruhe', 2, 'DE', 167),
('DE13', 'Freiburg', 0, 'Freiburg', 2, 'DE', 180),
('DE14', 'Tübingen', 0, 'Tübingen', 2, 'DE', 191),
('DE21', 'Oberbayern', 0, 'Oberbayern', 2, 'DE', 202),
('DE22', 'Niederbayern', 0, 'Niederbayern', 2, 'DE', 226),
('DE23', 'Oberpfalz', 0, 'Oberpfalz', 2, 'DE', 239),
('DE24', 'Oberfranken', 0, 'Oberfranken', 2, 'DE', 250),
('DE25', 'Mittelfranken', 0, 'Mittelfranken', 2, 'DE', 264),
('DE26', 'Unterfranken', 0, 'Unterfranken', 2, 'DE', 277),
('DE27', 'Schwaben', 0, 'Schwaben', 2, 'DE', 290),
('DE30', 'Berlin', 0, 'Berlin', 2, 'DE', 306),
('DE40', 'Brandenburg', 0, 'Brandenburg', 2, 'DE', 309),
('DE50', 'Bremen', 0, 'Bremen', 2, 'DE', 329),
('DE60', 'Hamburg', 0, 'Hamburg', 2, 'DE', 333),
('DE71', 'Darmstadt', 0, 'Darmstadt', 2, 'DE', 336),
('DE72', 'Gießen', 0, 'Gießen', 2, 'DE', 351),
('DE73', 'Kassel', 0, 'Kassel', 2, 'DE', 357),
('DE80', 'Mecklenburg-Vorpommern', 0, 'Mecklenburg-Vorpommern', 2, 'DE', 366),
('DE91', 'Braunschweig', 0, 'Braunschweig', 2, 'DE', 386),
('DE92', 'Hannover', 0, 'Hannover', 2, 'DE', 398),
('DE93', 'Lüneburg', 0, 'Lüneburg', 2, 'DE', 406),
('DE94', 'Weser-Ems', 0, 'Weser-Ems', 2, 'DE', 418),
('DEA1', 'Düsseldorf', 0, 'Düsseldorf', 2, 'DE', 437),
('DEA2', 'Köln', 0, 'Köln', 2, 'DE', 453),
('DEA3', 'Münster', 0, 'Münster', 2, 'DE', 465),
('DEA4', 'Detmold', 0, 'Detmold', 2, 'DE', 474),
('DEA5', 'Arnsberg', 0, 'Arnsberg', 2, 'DE', 482),
('DEB1', 'Koblenz', 0, 'Koblenz', 2, 'DE', 496),
('DEB2', 'Trier', 0, 'Trier', 2, 'DE', 508),
('DEB3', 'Rheinhessen-Pfalz', 0, 'Rheinhessen-Pfalz', 2, 'DE', 514),
('DEC0', 'Saarland', 0, 'Saarland', 2, 'DE', 536),
('DED2', 'Dresden', 0, 'Dresden', 2, 'DE', 544),
('DED3', 'Leipzig', 1, 'Leipzig', 2, 'DE', 556),
('DED4', 'Chemnitz', 0, 'Chemnitz', 2, 'DE', 550),
('DEE0', 'Sachsen-Anhalt', 0, 'Sachsen-Anhalt', 2, 'DE', 561),
('DEF0', 'Schleswig-Holstein', 0, 'Schleswig-Holstein', 2, 'DE', 577),
('DEG0', 'Thüringen', 0, 'Thüringen', 2, 'DE', 594),
('DK01', 'Hovedstaden', 0, 'Hovedstaden', 2, 'DK', 132),
('DK02', 'Sjælland', 0, 'Sjælland', 2, 'DK', 137),
('DK03', 'Syddanmark', 0, 'Syddanmark', 2, 'DK', 140),
('DK04', 'Midtjylland', 0, 'Midtjylland', 2, 'DK', 143),
('DK05', 'Nordjylland', 0, 'Nordjylland', 2, 'DK', 146),
('EE00', 'Eesti', 1, 'EESTI', 0, 'EE', 621),
('EL11', 'Anatoliki Makedonia, Thraki', 0, 'Aνατολική Μακεδονία, Θράκη (Anatoliki Makedonia, Thraki)', 2, 'EL', 649),
('EL12', 'Kentriki Makedonia', 0, 'Κεντρική Μακεδονία (Kentriki Makedonia)', 2, 'EL', 655),
('EL13', 'Dytiki Makedonia', 0, 'Δυτική Μακεδονία (Dytiki Makedonia)', 2, 'EL', 663),
('EL14', 'Thessalia', 0, 'Θεσσαλία (Thessalia)', 2, 'EL', 668),
('EL21', 'Ipeiros', 0, 'Ήπειρος (Ipeiros)', 2, 'EL', 674),
('EL22', 'Ionia Nisia', 0, 'Ιόνια Νησιά (Ionia Nisia)', 2, 'EL', 679),
('EL23', 'Dytiki Ellada', 0, 'Δυτική Ελλάδα (Dytiki Ellada)', 2, 'EL', 684),
('EL24', 'Sterea Ellada', 0, 'Στερεά Ελλάδα (Sterea Ellada)', 2, 'EL', 688),
('EL25', 'Peloponnisos', 0, 'Πελοπόννησος (Peloponnisos)', 2, 'EL', 694),
('EL30', 'Attiki', 0, 'Aττική (Attiki)', 2, 'EL', 701),
('EL41', 'Voreio Aigaio', 0, 'Βόρειο Αιγαίο (Voreio Aigaio)', 2, 'EL', 704),
('EL42', 'Notio Aigaio', 0, 'Νότιο Αιγαίο (Notio Aigaio)', 2, 'EL', 708),
('EL43', 'Kriti', 0, 'Κρήτη (Kriti)', 2, 'EL', 711),
('ES11', 'Galicia', 0, 'Galicia', 2, 'ES', 721),
('ES12', 'Principado de Asturias', 0, 'Principado de Asturias', 2, 'ES', 726),
('ES13', 'Cantabria', 0, 'Cantabria', 2, 'ES', 728),
('ES21', 'País Vasco', 0, 'País Vasco', 2, 'ES', 731),
('ES22', 'Comunidad Foral de Navarra', 0, 'Comunidad Foral de Navarra', 2, 'ES', 735),
('ES23', 'La Rioja', 0, 'La Rioja', 2, 'ES', 737),
('ES24', 'Aragón', 0, 'Aragón', 2, 'ES', 739),
('ES30', 'Comunidad de Madrid', 0, 'Comunidad de Madrid', 2, 'ES', 744),
('ES41', 'Castilla yLeón', 0, 'Castilla y León', 2, 'ES', 747),
('ES42', 'Castilla-La Mancha', 0, 'Castilla-La Mancha', 2, 'ES', 757),
('ES43', 'Extremadura', 0, 'Extremadura', 2, 'ES', 763),
('ES51', 'Cataluña', 0, 'Cataluña', 2, 'ES', 767),
('ES52', 'Comunidad Valenciana', 0, 'Comunidad Valenciana', 2, 'ES', 772),
('ES53', 'Illes Balears', 0, 'Illes Balears', 2, 'ES', 776),
('ES61', 'Andalucía', 0, 'Andalucía', 2, 'ES', 781),
('ES62', 'Región de Murcia', 0, 'Región de Murcia', 2, 'ES', 790),
('ES63', 'Ciudad Autónoma de Ceuta', 0, 'Ciudad Autónoma de Ceuta', 2, 'ES', 792),
('ES64', 'Ciudad Autónoma de Melilla', 0, 'Ciudad Autónoma de Melilla', 2, 'ES', 794),
('ES70', 'Canarias', 0, 'Canarias', 2, 'ES', 797),
('FI19', 'Länsi-Suomi', 0, 'Länsi-Suomi', 2, 'FI', 1542),
('FI1B', 'Helsinki-Uusimaa', 0, 'Helsinki-Uusimaa', 2, 'FI', 1548),
('FI1C', 'Etelä-Suomi', 1, 'Etelä-Suomi', 2, 'FI', 1550),
('FI1D', 'Pohjois-ja Itä-Suomi', 1, 'Pohjois- ja Itä-Suomi', 2, 'FI', 1556),
('FI20', 'Åland', 0, 'Åland', 2, 'FI', 1565),
('FR10', 'Île de France', 0, 'Île de France', 2, 'FR', 810),
('FR21', 'Champagne-Ardenne', 0, 'Champagne-Ardenne', 2, 'FR', 820),
('FR22', 'Picardie', 0, 'Picardie', 2, 'FR', 825),
('FR23', 'Haute-Normandie', 0, 'Haute-Normandie', 2, 'FR', 829),
('FR24', 'Centre', 0, 'Centre', 2, 'FR', 832),
('FR25', 'Basse-Normandie', 0, 'Basse-Normandie', 2, 'FR', 839),
('FR26', 'Bourgogne', 0, 'Bourgogne', 2, 'FR', 843),
('FR30', 'Nord - Pas-de-Calais', 0, 'Nord - Pas-de-Calais', 2, 'FR', 849),
('FR41', 'Lorraine', 0, 'Lorraine', 2, 'FR', 853),
('FR42', 'Alsace', 0, 'Alsace', 2, 'FR', 858),
('FR43', 'Franche-Comté', 0, 'Franche-Comté', 2, 'FR', 861),
('FR51', 'Pays deLaLoire', 0, 'Pays de la Loire', 2, 'FR', 867),
('FR52', 'Bretagne', 0, 'Bretagne', 2, 'FR', 873),
('FR53', 'Poitou-Charentes', 0, 'Poitou-Charentes', 2, 'FR', 878),
('FR61', 'Aquitaine', 0, 'Aquitaine', 2, 'FR', 884),
('FR62', 'Midi-Pyrénées', 0, 'Midi-Pyrénées', 2, 'FR', 890),
('FR63', 'Limousin', 0, 'Limousin', 2, 'FR', 899),
('FR71', 'Rhône-Alpes', 0, 'Rhône-Alpes', 2, 'FR', 904),
('FR72', 'Auvergne', 0, 'Auvergne', 2, 'FR', 913),
('FR81', 'Languedoc-Roussillon', 0, 'Languedoc-Roussillon', 2, 'FR', 919),
('FR82', 'Provence-Alpes-Côte d\"Azur', 0, 'Provence-Alpes-Côte d\"Azur', 2, 'FR', 925),
('FR83', 'Corse', 0, 'Corse', 2, 'FR', 932),
('FR91', 'Guadeloupe', 0, 'Guadeloupe', 2, 'FR', 936),
('FR92', 'Martinique', 0, 'Martinique', 2, 'FR', 938),
('FR93', 'Guyane', 0, 'Guyane', 2, 'FR', 940),
('FR94', 'Réunion', 0, 'Réunion', 2, 'FR', 942),
('HR03', 'Jadranska Hrvatska', 0, 'Jadranska Hrvatska', 2, 'HR', 949),
('HR04', 'Kontinentalna Hrvatska', 0, 'Kontinentalna Hrvatska', 2, 'HR', 957),
('HU10', 'Kozep-Magyarorszag', 0, 'Közép-Magyarország', 2, 'HU', 1159),
('HU21', 'Kozep-Dunantul', 0, 'Közép-Dunántúl', 2, 'HU', 1163),
('HU22', 'Nyugat-Dunantul', 0, 'Nyugat-Dunántúl', 2, 'HU', 1167),
('HU23', 'Del-Dunantul', 0, 'Dél-Dunántúl', 2, 'HU', 1171),
('HU31', 'Eszak-Magyarorszag', 0, 'Észak-Magyarország', 2, 'HU', 1176),
('HU32', 'Eszak-Alfold', 0, 'Észak-Alföld', 2, 'HU', 1180),
('HU33', 'Del-Alfold', 0, 'Dél-Alföld', 2, 'HU', 1184),
('IE01', 'Border, Midland and Western', 0, 'Border, Midland and Western', 2, 'IE', 634),
('IE02', 'Southern and Eastern', 0, 'Southern and Eastern', 2, 'IE', 638),
('ITC1', 'Piemonte', 0, 'Piemonte', 2, 'IT', 977),
('ITC2', 'Valle d\"Aosta/Vallée d\"Aoste', 0, 'Valle d\"Aosta/Vallée d\"Aoste', 2, 'IT', 986),
('ITC3', 'Liguria', 0, 'Liguria', 2, 'IT', 988),
('ITC4', 'Lombardia', 0, 'Lombardia', 2, 'IT', 993),
('ITD1', 'Provincia Autonoma Bolzano/Bozen', 1, 'Provincia Autonoma di Bolzano/Bozen', 2, 'IT', 1058),
('ITD2', 'Provincia Autonoma Trento', 1, 'Provincia Autonoma di Trento', 2, 'IT', 1060),
('ITD3', 'Veneto', 1, 'Veneto', 2, 'IT', 1062),
('ITD4', 'Friuli-Venezia Giulia', 1, 'Friuli-Venezia Giulia', 2, 'IT', 1070),
('ITD5', 'Emilia-Romagna', 1, 'Emilia-Romagna', 2, 'IT', 1075),
('ITE1', 'Toscana', 1, 'Toscana', 2, 'IT', 1086),
('ITE2', 'Umbria', 1, 'Umbria', 2, 'IT', 1097),
('ITE3', 'Marche', 1, 'Marche', 2, 'IT', 1100),
('ITE4', 'Lazio', 1, 'Lazio', 2, 'IT', 1106),
('ITF1', 'Abruzzo', 0, 'Abruzzo', 2, 'IT', 1007),
('ITF2', 'Molise', 0, 'Molise', 2, 'IT', 1012),
('ITF3', 'Campania', 0, 'Campania', 2, 'IT', 1015),
('ITF4', 'Puglia', 0, 'Puglia', 2, 'IT', 1021),
('ITF5', 'Basilicata', 0, 'Basilicata', 2, 'IT', 1028),
('ITF6', 'Calabria', 0, 'Calabria', 2, 'IT', 1031),
('ITG1', 'Sicilia', 0, 'Sicilia', 2, 'IT', 1038),
('ITG2', 'Sardegna', 0, 'Sardegna', 2, 'IT', 1048),
('LT00', 'Lietuva', 0, 'Lietuva', 2, 'LT', 1136),
('LU00', 'Luxembourg (Grand-Duché)', 0, 'Luxembourg', 2, 'LU', 1152),
('LV00', 'Latvija', 0, 'Latvija', 2, 'LV', 1124),
('MT00', 'Malta', 0, 'Malta', 2, 'MT', 1193),
('NL11', 'Groningen', 0, 'Groningen', 2, 'NL', 1201),
('NL12', 'Friesland (NL)', 0, 'Friesland (NL)', 2, 'NL', 1205),
('NL13', 'Drenthe', 0, 'Drenthe', 2, 'NL', 1209),
('NL21', 'Overijssel', 0, 'Overijssel', 2, 'NL', 1214),
('NL22', 'Gelderland', 0, 'Gelderland', 2, 'NL', 1218),
('NL23', 'Flevoland', 0, 'Flevoland', 2, 'NL', 1223),
('NL31', 'Utrecht', 0, 'Utrecht', 2, 'NL', 1226),
('NL32', 'Noord-Holland', 0, 'Noord-Holland', 2, 'NL', 1228),
('NL33', 'Zuid-Holland', 0, 'Zuid-Holland', 2, 'NL', 1236),
('NL34', 'Zeeland', 0, 'Zeeland', 2, 'NL', 1243),
('NL41', 'Noord-Brabant', 0, 'Noord-Brabant', 2, 'NL', 1247),
('NL42', 'Limburg (NL)', 0, 'Limburg (NL)', 2, 'NL', 1252),
('PL11', 'Lodzkie', 0, 'Łódzkie', 2, 'PL', 1312),
('PL12', 'Mazowieckie', 0, 'Mazowieckie', 2, 'PL', 1318),
('PL21', 'Malopolskie', 0, 'Małopolskie', 2, 'PL', 1326),
('PL22', 'Slaskie', 0, 'Śląskie', 2, 'PL', 1332),
('PL31', 'Lubelskie', 0, 'Lubelskie', 2, 'PL', 1342),
('PL32', 'Podkarpackie', 0, 'Podkarpackie', 2, 'PL', 1347),
('PL33', 'Swietokrzyskie', 0, 'Świętokrzyskie', 2, 'PL', 1352),
('PL34', 'Podlaskie', 0, 'Podlaskie', 2, 'PL', 1355),
('PL41', 'Wielkopolskie', 0, 'Wielkopolskie', 2, 'PL', 1360),
('PL42', 'Zachodniopomorskie', 0, 'Zachodniopomorskie', 2, 'PL', 1367),
('PL43', 'Lubuskie', 0, 'Lubuskie', 2, 'PL', 1372),
('PL51', 'Dolnoslaskie', 0, 'Dolnośląskie', 2, 'PL', 1376),
('PL52', 'Opolskie', 0, 'Opolskie', 2, 'PL', 1382),
('PL61', 'Kujawsko-Pomorskie', 0, 'Kujawsko-Pomorskie', 2, 'PL', 1386),
('PL62', 'Warminsko-Mazurskie', 0, 'Warmińsko-Mazurskie', 2, 'PL', 1390),
('PL63', 'Pomorskie', 0, 'Pomorskie', 2, 'PL', 1394),
('PT11', 'Norte', 0, 'Norte', 2, 'PT', 1404),
('PT15', 'Algarve', 0, 'Algarve', 2, 'PT', 1413),
('PT16', 'Centro (P)', 0, 'Centro (PT)', 2, 'PT', 1415),
('PT17', 'Lisboa', 0, 'Lisboa', 2, 'PT', 1428),
('PT18', 'Alentejo', 0, 'Alentejo', 2, 'PT', 1431),
('PT20', 'Região Autónoma dos Açores', 0, 'Região Autónoma dos Açores', 2, 'PT', 1438),
('PT30', 'Região Autónoma da Madeira', 0, 'Região Autónoma da Madeira', 2, 'PT', 1441),
('RO11', 'Nord-Vest', 0, 'Nord-Vest', 2, 'RO', 1448),
('RO12', 'Centru', 0, 'Centru', 2, 'RO', 1455),
('RO21', 'Nord-Est', 0, 'Nord-Est', 2, 'RO', 1463),
('RO22', 'Sud-Est', 0, 'Sud-Est', 2, 'RO', 1470),
('RO31', 'Sud - Muntenia', 0, 'Sud - Muntenia', 2, 'RO', 1478),
('RO32', 'Bucuresti - Ilfov', 0, 'Bucureşti - Ilfov', 2, 'RO', 1486),
('RO41', 'Sud-Vest Oltenia', 0, 'Sud-Vest Oltenia', 2, 'RO', 1490),
('RO42', 'Vest', 0, 'Vest', 2, 'RO', 1496),
('SE11', 'Stockholm', 0, 'Stockholm', 2, 'SE', 1572),
('SE12', 'Östra Mellansverige', 0, 'Östra Mellansverige', 2, 'SE', 1574),
('SE21', 'Småland med öarna', 0, 'Småland med öarna', 2, 'SE', 1581),
('SE22', 'Sydsverige', 0, 'Sydsverige', 2, 'SE', 1586),
('SE23', 'Västsverige', 0, 'Västsverige', 2, 'SE', 1589),
('SE31', 'Norra Mellansverige', 0, 'Norra Mellansverige', 2, 'SE', 1593),
('SE32', 'Mellersta Norrland', 0, 'Mellersta Norrland', 2, 'SE', 1597),
('SE33', 'Övre Norrland', 0, 'Övre Norrland', 2, 'SE', 1600),
('SI01', 'Vzhodna Slovenija', 0, 'Vzhodna Slovenija', 2, 'SI', 1506),
('SI02', 'Zahodna Slovenija', 0, 'Zahodna Slovenija', 2, 'SI', 1515),
('SK01', 'Bratislavsky kraj', 0, 'Bratislavský kraj', 2, 'SK', 1525),
('SK02', 'Zapadne Slovensko', 0, 'Západné Slovensko', 2, 'SK', 1527),
('SK03', 'Stredne Slovensko', 0, 'Stredné Slovensko', 2, 'SK', 1531),
('SK04', 'Vychodne Slovensko', 0, 'Východné Slovensko', 2, 'SK', 1534),
('UKC1', 'Tees Valley and Durham', 0, 'Tees Valley and Durham', 2, 'UK', 1608),
('UKC2', 'Northumberland and Tyne and Wear', 0, 'Northumberland and Tyne and Wear', 2, 'UK', 1613),
('UKD1', 'Cumbria', 0, 'Cumbria', 2, 'UK', 1618),
('UKD2', 'Cheshire', 1, 'Cheshire', 2, 'UK', 1628),
('UKD3', 'Greater Manchester', 1, 'Greater Manchester', 2, 'UK', 1621),
('UKD4', 'Lancashire', 1, 'Lancashire', 2, 'UK', 1624),
('UKD5', 'Merseyside', 1, 'Merseyside', 2, 'UK', 1632),
('UKE1', 'East Yorkshire and NorthernLincolnshire', 0, 'East Yorkshire and Northern Lincolnshire', 2, 'UK', 1638),
('UKE2', 'North Yorkshire', 0, 'North Yorkshire', 2, 'UK', 1642),
('UKE3', 'South Yorkshire', 0, 'South Yorkshire', 2, 'UK', 1645),
('UKE4', 'West Yorkshire', 0, 'West Yorkshire', 2, 'UK', 1648),
('UKF1', 'Derbyshire and Nottinghamshire', 0, 'Derbyshire and Nottinghamshire', 2, 'UK', 1654),
('UKF2', 'Leicestershire, Rutland and Northamptonshire', 0, 'Leicestershire, Rutland and Northamptonshire', 2, 'UK', 1661),
('UKF3', 'Lincolnshire', 0, 'Lincolnshire', 2, 'UK', 1666),
('UKG1', 'Herefordshire, Worcestershire and Warwickshire', 0, 'Herefordshire, Worcestershire and Warwickshire', 2, 'UK', 1669),
('UKG2', 'Shropshire and Staffordshire', 0, 'Shropshire and Staffordshire', 2, 'UK', 1673),
('UKG3', 'West Midlands', 0, 'West Midlands', 2, 'UK', 1678),
('UKH1', 'East Anglia', 0, 'East Anglia', 2, 'UK', 1687),
('UKH2', 'Bedfordshire and Hertfordshire', 0, 'Bedfordshire and Hertfordshire', 2, 'UK', 1692),
('UKH3', 'Essex', 0, 'Essex', 2, 'UK', 1697),
('UKI1', 'InnerLondon', 0, 'Inner London', 2, 'UK', 1702),
('UKI2', 'OuterLondon', 0, 'Outer London', 2, 'UK', 1705),
('UKJ1', 'Berkshire, Buckinghamshire and Oxfordshire', 0, 'Berkshire, Buckinghamshire and Oxfordshire', 2, 'UK', 1710),
('UKJ2', 'Surrey, East and West Sussex', 0, 'Surrey, East and West Sussex', 2, 'UK', 1715),
('UKJ3', 'Hampshire and Isle of Wight', 0, 'Hampshire and Isle of Wight', 2, 'UK', 1720),
('UKJ4', 'Kent', 0, 'Kent', 2, 'UK', 1725),
('UKK1', 'Gloucestershire, Wiltshire and Bristol/Bath area', 0, 'Gloucestershire, Wiltshire and Bristol/Bath area', 2, 'UK', 1729),
('UKK2', 'Dorset and Somerset', 0, 'Dorset and Somerset', 2, 'UK', 1735),
('UKK3', 'Cornwall and Isles of Scilly', 0, 'Cornwall and Isles of Scilly', 2, 'UK', 1739),
('UKK4', 'Devon', 0, 'Devon', 2, 'UK', 1741),
('UKL1', 'West Wales and The Valleys', 0, 'West Wales and The Valleys', 2, 'UK', 1746),
('UKL2', 'East Wales', 0, 'East Wales', 2, 'UK', 1755),
('UKM2', 'Eastern Scotland', 0, 'Eastern Scotland', 2, 'UK', 1761),
('UKM3', 'South Western Scotland', 0, 'South Western Scotland', 2, 'UK', 1770),
('UKM5', 'North Eastern Scotland', 0, 'North Eastern Scotland', 2, 'UK', 1779),
('UKM6', 'Highlands and Islands', 0, 'Highlands and Islands', 2, 'UK', 1781),
('UKN0', 'Northern Ireland', 0, 'Northern Ireland', 2, 'UK', 1789);

-- --------------------------------------------------------

--
-- Table structure for table `wp_commentmeta`
--

CREATE TABLE `wp_commentmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wp_comments`
--

CREATE TABLE `wp_comments` (
  `comment_ID` bigint(20) UNSIGNED NOT NULL,
  `comment_post_ID` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `comment_author` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wp_comments`
--

INSERT INTO `wp_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(1, 1, 'Mr WordPress', '', 'https://wordpress.org/', '', '2017-06-02 11:52:08', '2017-06-02 10:52:08', 'Hi, this is a comment.\nTo delete a comment, just log in and view the post&#039;s comments. There you will have the option to edit or delete them.', 0, '1', '', '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `wp_links`
--

CREATE TABLE `wp_links` (
  `link_id` bigint(20) UNSIGNED NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) UNSIGNED NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wp_options`
--

CREATE TABLE `wp_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wp_options`
--

INSERT INTO `wp_options` (`option_id`, `option_name`, `option_value`, `autoload`) VALUES
(1, 'siteurl', 'http://budgeting.s3platform.eu', 'yes'),
(2, 'home', 'http://budgeting.s3platform.eu', 'yes'),
(3, 'blogname', 'RIS budgeting', 'yes'),
(4, 'blogdescription', '', 'yes'),
(5, 'users_can_register', '1', 'yes'),
(6, 'admin_email', 'elvi.galanaki@gmail.com', 'yes'),
(7, 'start_of_week', '1', 'yes'),
(8, 'use_balanceTags', '0', 'yes'),
(9, 'use_smilies', '1', 'yes'),
(10, 'require_name_email', '1', 'yes'),
(11, 'comments_notify', '1', 'yes'),
(12, 'posts_per_rss', '10', 'yes'),
(13, 'rss_use_excerpt', '0', 'yes'),
(14, 'mailserver_url', 'mail.example.com', 'yes'),
(15, 'mailserver_login', 'login@example.com', 'yes'),
(16, 'mailserver_pass', 'password', 'yes'),
(17, 'mailserver_port', '110', 'yes'),
(18, 'default_category', '1', 'yes'),
(19, 'default_comment_status', 'open', 'yes'),
(20, 'default_ping_status', 'open', 'yes'),
(21, 'default_pingback_flag', '1', 'yes'),
(22, 'posts_per_page', '10', 'yes'),
(23, 'date_format', 'jS F Y', 'yes'),
(24, 'time_format', 'g:i a', 'yes'),
(25, 'links_updated_date_format', 'jS F Y g:i a', 'yes'),
(26, 'comment_moderation', '0', 'yes'),
(27, 'moderation_notify', '1', 'yes'),
(28, 'permalink_structure', '/%year%/%monthnum%/%day%/%postname%/', 'yes'),
(29, 'rewrite_rules', 'a:115:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:6:\"^auth0\";s:17:\"index.php?auth0=1\";s:41:\"^\\.well-known/oauth2-client-configuration\";s:33:\"index.php?a0_action=oauth2-config\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:41:\"wbcr-snippets/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:51:\"wbcr-snippets/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:71:\"wbcr-snippets/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:66:\"wbcr-snippets/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:66:\"wbcr-snippets/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:47:\"wbcr-snippets/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:30:\"wbcr-snippets/([^/]+)/embed/?$\";s:61:\"index.php?post_type=wbcr-snippets&name=$matches[1]&embed=true\";s:34:\"wbcr-snippets/([^/]+)/trackback/?$\";s:55:\"index.php?post_type=wbcr-snippets&name=$matches[1]&tb=1\";s:42:\"wbcr-snippets/([^/]+)/page/?([0-9]{1,})/?$\";s:68:\"index.php?post_type=wbcr-snippets&name=$matches[1]&paged=$matches[2]\";s:49:\"wbcr-snippets/([^/]+)/comment-page-([0-9]{1,})/?$\";s:68:\"index.php?post_type=wbcr-snippets&name=$matches[1]&cpage=$matches[2]\";s:38:\"wbcr-snippets/([^/]+)(?:/([0-9]+))?/?$\";s:67:\"index.php?post_type=wbcr-snippets&name=$matches[1]&page=$matches[2]\";s:30:\"wbcr-snippets/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:40:\"wbcr-snippets/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:60:\"wbcr-snippets/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:55:\"wbcr-snippets/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:55:\"wbcr-snippets/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:36:\"wbcr-snippets/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:58:\"wbcr-snippet-tags/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:70:\"index.php?taxonomy=wbcr-snippet-tags&term=$matches[1]&feed=$matches[2]\";s:53:\"wbcr-snippet-tags/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:70:\"index.php?taxonomy=wbcr-snippet-tags&term=$matches[1]&feed=$matches[2]\";s:34:\"wbcr-snippet-tags/([^/]+)/embed/?$\";s:64:\"index.php?taxonomy=wbcr-snippet-tags&term=$matches[1]&embed=true\";s:46:\"wbcr-snippet-tags/([^/]+)/page/?([0-9]{1,})/?$\";s:71:\"index.php?taxonomy=wbcr-snippet-tags&term=$matches[1]&paged=$matches[2]\";s:28:\"wbcr-snippet-tags/([^/]+)/?$\";s:53:\"index.php?taxonomy=wbcr-snippet-tags&term=$matches[1]\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:27:\"comment-page-([0-9]{1,})/?$\";s:38:\"index.php?&page_id=4&cpage=$matches[1]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:58:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:68:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:88:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:83:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:64:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:53:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/embed/?$\";s:91:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/trackback/?$\";s:85:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&tb=1\";s:77:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&feed=$matches[5]\";s:65:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/page/?([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&paged=$matches[5]\";s:72:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)/comment-page-([0-9]{1,})/?$\";s:98:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&cpage=$matches[5]\";s:61:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/([^/]+)(?:/([0-9]+))?/?$\";s:97:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&name=$matches[4]&page=$matches[5]\";s:47:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:57:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:77:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:72:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:53:\"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&cpage=$matches[4]\";s:51:\"([0-9]{4})/([0-9]{1,2})/comment-page-([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&cpage=$matches[3]\";s:38:\"([0-9]{4})/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&cpage=$matches[2]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";}', 'yes'),
(30, 'hack_file', '0', 'yes'),
(31, 'blog_charset', 'UTF-8', 'yes'),
(32, 'moderation_keys', '', 'no'),
(33, 'active_plugins', 'a:5:{i:0;s:18:\"auth0/WP_Auth0.php\";i:1;s:25:\"insert-php/insert_php.php\";i:2;s:47:\"really-simple-ssl/rlrsssl-really-simple-ssl.php\";i:3;s:25:\"sucuri-scanner/sucuri.php\";i:4;s:27:\"wp-super-cache/wp-cache.php\";}', 'yes'),
(34, 'category_base', '', 'yes'),
(35, 'ping_sites', 'http://rpc.pingomatic.com/', 'yes'),
(36, 'comment_max_links', '2', 'yes'),
(37, 'gmt_offset', '', 'yes'),
(38, 'default_email_category', '1', 'yes'),
(39, 'recently_edited', 'a:3:{i:0;s:81:\"/home/intelelv1/budgeting.s3platform.eu/wp-content/themes/twentysixteen/style.css\";i:1;s:76:\"/home/intelelv1/budgeting.s3platform.eu/wp-content/themes/onlineS3/style.css\";i:2;s:0:\"\";}', 'no'),
(40, 'template', 'twentysixteen', 'yes'),
(41, 'stylesheet', 'onlineS3', 'yes'),
(42, 'comment_whitelist', '1', 'yes'),
(43, 'blacklist_keys', '', 'no'),
(44, 'comment_registration', '0', 'yes'),
(45, 'html_type', 'text/html', 'yes'),
(46, 'use_trackback', '0', 'yes'),
(47, 'default_role', 'subscriber', 'yes'),
(48, 'db_version', '38590', 'yes'),
(49, 'uploads_use_yearmonth_folders', '1', 'yes'),
(50, 'upload_path', '', 'yes'),
(51, 'blog_public', '1', 'yes'),
(52, 'default_link_category', '2', 'yes'),
(53, 'show_on_front', 'page', 'yes'),
(54, 'tag_base', '', 'yes'),
(55, 'show_avatars', '1', 'yes'),
(56, 'avatar_rating', 'G', 'yes'),
(57, 'upload_url_path', '', 'yes'),
(58, 'thumbnail_size_w', '150', 'yes'),
(59, 'thumbnail_size_h', '150', 'yes'),
(60, 'thumbnail_crop', '1', 'yes'),
(61, 'medium_size_w', '300', 'yes'),
(62, 'medium_size_h', '300', 'yes'),
(63, 'avatar_default', 'mystery', 'yes'),
(64, 'large_size_w', '1024', 'yes'),
(65, 'large_size_h', '1024', 'yes'),
(66, 'image_default_link_type', 'none', 'yes'),
(67, 'image_default_size', '', 'yes'),
(68, 'image_default_align', '', 'yes'),
(69, 'close_comments_for_old_posts', '0', 'yes'),
(70, 'close_comments_days_old', '14', 'yes'),
(71, 'thread_comments', '1', 'yes'),
(72, 'thread_comments_depth', '5', 'yes'),
(73, 'page_comments', '0', 'yes'),
(74, 'comments_per_page', '50', 'yes'),
(75, 'default_comments_page', 'newest', 'yes'),
(76, 'comment_order', 'asc', 'yes'),
(77, 'sticky_posts', 'a:0:{}', 'yes'),
(78, 'widget_categories', 'a:2:{i:2;a:4:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:12:\"hierarchical\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(79, 'widget_text', 'a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}', 'yes'),
(80, 'widget_rss', 'a:2:{i:1;a:0:{}s:12:\"_multiwidget\";i:1;}', 'yes'),
(81, 'uninstall_plugins', 'a:3:{s:18:\"auth0/WP_Auth0.php\";a:2:{i:0;s:8:\"WP_Auth0\";i:1;s:9:\"uninstall\";}s:27:\"wp-super-cache/wp-cache.php\";s:22:\"wpsupercache_uninstall\";s:25:\"sucuri-scanner/sucuri.php\";s:19:\"sucuriscanUninstall\";}', 'no'),
(82, 'timezone_string', 'Europe/London', 'yes'),
(83, 'page_for_posts', '0', 'yes'),
(84, 'page_on_front', '4', 'yes'),
(85, 'default_post_format', '0', 'yes'),
(86, 'link_manager_enabled', '0', 'yes'),
(87, 'finished_splitting_shared_terms', '1', 'yes'),
(88, 'site_icon', '0', 'yes'),
(89, 'medium_large_size_w', '768', 'yes'),
(90, 'medium_large_size_h', '0', 'yes'),
(91, 'initial_db_version', '36686', 'yes'),
(92, 'wp_user_roles', 'a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:68:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;s:18:\"edit_wbcr-snippets\";b:1;s:18:\"read_wbcr-snippets\";b:1;s:20:\"delete_wbcr-snippets\";b:1;s:19:\"edit_wbcr-snippetss\";b:1;s:26:\"edit_others_wbcr-snippetss\";b:1;s:22:\"publish_wbcr-snippetss\";b:1;s:27:\"read_private_wbcr-snippetss\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}}', 'yes'),
(93, 'WPLANG', 'en_GB', 'yes'),
(94, 'widget_search', 'a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}', 'yes'),
(95, 'widget_recent-posts', 'a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(96, 'widget_recent-comments', 'a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(97, 'widget_archives', 'a:2:{i:2;a:3:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}', 'yes'),
(98, 'widget_meta', 'a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}', 'yes'),
(99, 'sidebars_widgets', 'a:5:{s:19:\"wp_inactive_widgets\";N;s:9:\"sidebar-1\";a:0:{}s:9:\"sidebar-2\";N;s:9:\"sidebar-3\";N;s:13:\"array_version\";i:3;}', 'yes'),
(100, 'widget_pages', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(101, 'widget_calendar', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(102, 'widget_tag_cloud', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(103, 'widget_nav_menu', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(104, 'cron', 'a:7:{i:1543228782;a:1:{s:34:\"wp_privacy_delete_old_export_files\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:6:\"hourly\";s:4:\"args\";a:0:{}s:8:\"interval\";i:3600;}}}i:1543229529;a:3:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1543229538;a:1:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1543229660;a:1:{s:30:\"wp_scheduled_auto_draft_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1543237012;a:1:{s:25:\"sucuriscan_scheduled_scan\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1543311582;a:1:{s:25:\"delete_expired_transients\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}s:7:\"version\";i:2;}', 'yes'),
(107, 'nonce_key', '0}&qvDw`,OY)(5]-:+,a+t1/s(2MTv|K-Rh*{!LV)2^zTC]VJGZdz]gR,j4:/uaj', 'yes'),
(108, 'nonce_salt', 'DIk?PEeU.dq.PN_PYl+Qgvq2+8nv+6@VdlJF!ev>EAZ*fG63*dLW$l{~KF2:ZuW>', 'yes'),
(111, 'auth_key', 'sL|KY3IK)LrM+8Facf-wL5{3Qvn`pft|2T(CT%B4ttfi3f]+w3_y}ANvUulrqi20', 'yes'),
(112, 'auth_salt', '%DW|7)|F.p:X2{#/IuJ&_q|h<#sDvZ 4D`y%<L%fd/O *wO3 St4XdHzuT3{L+jn', 'yes'),
(113, 'logged_in_key', 'c/Zz3:@2AQYND6A)n+0*>B5hU/+t$qp-WTewe2<=G&s7b-2|ZUOV9460M-6Kf0P$', 'yes'),
(114, 'logged_in_salt', 'G?eS<ymPAtKfyE06$#;:xb?%Y}rIe}-U(zx :<xgo/Ms^sg-0A0R|Y}&dA^lNls=', 'yes'),
(146, 'auto_core_update_notified', 'a:4:{s:4:\"type\";s:7:\"success\";s:5:\"email\";s:23:\"elvi.galanaki@gmail.com\";s:7:\"version\";s:5:\"4.9.8\";s:9:\"timestamp\";i:1533250859;}', 'no'),
(147, 'recently_activated', 'a:0:{}', 'yes'),
(158, 'current_theme', 'OnlineS3', 'yes'),
(159, 'theme_mods_onlineS3', 'a:4:{i:0;b:0;s:18:\"custom_css_post_id\";i:-1;s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1542726682;s:4:\"data\";a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:0:{}s:9:\"sidebar-2\";N;s:9:\"sidebar-3\";N;}}s:18:\"nav_menu_locations\";a:0:{}}', 'yes'),
(160, 'theme_switched', '', 'yes'),
(171, 'db_upgraded', '', 'yes'),
(174, 'can_compress_scripts', '0', 'no'),
(177, 'theme_mods_twentysixteen', 'a:5:{i:0;b:0;s:18:\"custom_css_post_id\";i:-1;s:16:\"header_textcolor\";s:5:\"blank\";s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1542891700;s:4:\"data\";a:4:{s:19:\"wp_inactive_widgets\";N;s:9:\"sidebar-1\";a:0:{}s:9:\"sidebar-2\";N;s:9:\"sidebar-3\";N;}}s:18:\"nav_menu_locations\";a:0:{}}', 'yes'),
(178, 'fresh_site', '0', 'yes'),
(217, 'widget_media_audio', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(218, 'widget_media_image', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(219, 'widget_media_video', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(702, 'widget_custom_html', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(1106, 'wp_auth0_settings', 'a:56:{s:6:\"domain\";s:21:\"onlines3.eu.auth0.com\";s:13:\"custom_domain\";s:0:\"\";s:9:\"client_id\";s:32:\"kh1rSVXOCsqfqZnsUzyxgjjL9W72TYNi\";s:13:\"client_secret\";s:64:\"S9LTDdf1DxKTwNGQkbu9qnIJtdkJnp-mQiEZHKJHB7RFcM7C4LHFUe-mOddfJ4ze\";s:24:\"client_signing_algorithm\";s:5:\"HS256\";s:16:\"cache_expiration\";i:1440;s:15:\"auth0_app_token\";s:964:\"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IlJERTFPRVV5UkRFNFJVWTVPVGRCT0RNM09UZ3hNRUpFTWtGQ01VUkZRVGcxTlRVeFJERkRSQSJ9.eyJpc3MiOiJodHRwczovL2F1dGgwLmF1dGgwLmNvbS8iLCJzdWIiOiJnb29nbGUtb2F1dGgyfDEwMjI1Mjc1ODUwMzY3MDI3NjM4MCIsImF1ZCI6Imh0dHBzOi8vZWx2aS5ldS5hdXRoMC5jb20vYXBpL3YyLyIsImlhdCI6MTUwNTczNjk5MCwiZXhwIjoxNTA1NzcyOTkwLCJhenAiOiJodHRwOi8vYnVkZ2V0aW5nLnMzcGxhdGZvcm0uZXUiLCJzY29wZSI6ImNyZWF0ZTpjbGllbnRzIHVwZGF0ZTpjbGllbnRzIHVwZGF0ZTpjb25uZWN0aW9ucyBjcmVhdGU6Y29ubmVjdGlvbnMgcmVhZDpjb25uZWN0aW9ucyBjcmVhdGU6cnVsZXMgZGVsZXRlOnJ1bGVzIHJlYWQ6dXNlcnMgdXBkYXRlOnVzZXJzIGNyZWF0ZTp1c2VycyB1cGRhdGU6Z3VhcmRpYW5fZmFjdG9ycyJ9.qivryM-BgFys7g4hopCJJzD14Yg5OG846teUnawwFUCom8TuBN41PA94z5l9K8w2iWpIydGBeN2if3rWQOP-AUvRccGjM_T5yUCTguvhqLHZaRj69HZswzY9rpmgt3iMTiH2cwKciGKA8paxI0xab3TlbUiERpvAV3ViiPQ6YYV20DAUNul54d9311h6DGlxYyQN0mzpfAXqLG8yIISxxfZGeAmes2l9RbrCIW3A6CX47uSkTjcCEt_xFYcVldIfZH6F93RekF11wpF8ZQxECepHuTR3Lzpts9dfwjIQ5KSu-ffIfcuDcplexXCgQSgKjQWiH2F52omz1NVOEzum2A\";s:23:\"wordpress_login_enabled\";s:1:\"1\";s:15:\"password_policy\";s:4:\"fair\";s:3:\"sso\";s:1:\"1\";s:17:\"auto_login_method\";s:0:\"\";s:18:\"fullcontact_apikey\";s:0:\"\";s:8:\"icon_url\";s:66:\"http://budgeting.s3platform.eu/wp-content/uploads/2017/11/logo.png\";s:10:\"form_title\";s:18:\"5.3 RIS3 budgeting\";s:8:\"gravatar\";s:1:\"1\";s:10:\"custom_css\";s:0:\"\";s:9:\"custom_js\";s:0:\"\";s:14:\"username_style\";s:0:\"\";s:13:\"primary_color\";s:16:\"rgb(0, 111, 180)\";s:8:\"language\";s:0:\"\";s:19:\"language_dictionary\";s:0:\"\";s:23:\"requires_verified_email\";i:1;s:15:\"skip_strategies\";s:0:\"\";s:25:\"default_login_redirection\";s:48:\"http://budgeting.s3platform.eu/index.php?auth0=1\";s:16:\"lock_connections\";s:0:\"\";s:7:\"cdn_url\";s:46:\"https://cdn.auth0.com/js/lock/11.5/lock.min.js\";s:13:\"migration_ips\";s:52:\"52.28.56.226,52.28.45.240,52.16.224.164,52.16.193.66\";s:9:\"ip_ranges\";s:0:\"\";s:14:\"valid_proxy_ip\";s:0:\"\";s:10:\"extra_conf\";s:0:\"\";s:20:\"custom_signup_fields\";s:0:\"\";s:18:\"social_twitter_key\";s:0:\"\";s:21:\"social_twitter_secret\";s:0:\"\";s:19:\"social_facebook_key\";s:0:\"\";s:22:\"social_facebook_secret\";s:0:\"\";s:19:\"auth0_server_domain\";s:15:\"auth0.auth0.com\";s:12:\"allow_signup\";i:0;s:25:\"client_secret_b64_encoded\";b:0;s:12:\"singlelogout\";i:0;s:19:\"override_wp_avatars\";i:0;s:8:\"geo_rule\";N;s:11:\"income_rule\";N;s:11:\"fullcontact\";N;s:3:\"mfa\";N;s:18:\"social_big_buttons\";i:0;s:17:\"auto_provisioning\";i:0;s:22:\"remember_users_session\";b:0;s:20:\"passwordless_enabled\";b:0;s:20:\"jwt_auth_integration\";i:0;s:23:\"auth0_implicit_workflow\";i:0;s:20:\"force_https_callback\";i:0;s:20:\"migration_ips_filter\";i:0;s:12:\"migration_ws\";i:0;s:15:\"migration_token\";N;s:18:\"migration_token_id\";N;s:16:\"link_auth0_users\";N;}', 'yes'),
(1107, 'auth0_db_version', '19', 'yes'),
(1108, 'widget_wp_auth0_widget', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(1109, 'widget_wp_auth0_popup_widget', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(1110, 'widget_wp_auth0_social_amplification_widget', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(1111, 'auth0_error_log', 'a:20:{i:0;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538990177;}i:1;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538752714;}i:2;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538752698;}i:3;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538739407;}i:4;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538737386;}i:5;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538737384;}i:6;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538737373;}i:7;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538737363;}i:8;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1538737358;}i:9;a:4:{s:7:\"section\";s:37:\"WP_Auth0_Api_Client::get_client_token\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:272:\"{\"error\":\"access_denied\",\"error_description\":\"Client is not authorized to access \\\"https://onlines3.eu.auth0.com/api/v2/\\\". You might probably want to create a \\\"client-grant\\\" associated to this API. See: https://auth0.com/docs/api/v2#!/Client_Grants/post_client_grants\"}\";s:4:\"date\";i:1536833734;}i:10;a:4:{s:7:\"section\";s:30:\"WP_Auth0_DBManager::install_db\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:205:\"Unable to automatically update Client Grant Type. Please go to your Auth0 Dashboard and add Client Credentials to your Application settings > Advanced > Grant Types for ID kh1rSVXOCsqfqZnsUzyxgjjL9W72TYNi \";s:4:\"date\";i:1536833734;}i:11;a:4:{s:7:\"section\";s:30:\"WP_Auth0_DBManager::install_db\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:321:\"Unable to automatically create Client Grant. Please go to your Auth0 Dashboard and authorize your Application kh1rSVXOCsqfqZnsUzyxgjjL9W72TYNi for management API scopes update:clients, update:connections, create:connections, read:connections, create:rules, delete:rules, read:users, update:users, update:guardian_factors.\";s:4:\"date\";i:1536833734;}i:12;a:4:{s:7:\"section\";s:30:\"WP_Auth0_DBManager::install_db\";s:4:\"code\";s:12:\"unknown_code\";s:7:\"message\";s:31:\"OpenSSL unable to verify data: \";s:4:\"date\";i:1536833734;}i:13;a:4:{s:7:\"section\";s:22:\"init_auth0_oauth/token\";s:4:\"code\";s:15:\"invalid_request\";s:7:\"message\";s:32:\"Missing required parameter: code\";s:4:\"date\";i:1529485883;}i:14;a:4:{s:7:\"section\";s:22:\"init_auth0_oauth/token\";s:4:\"code\";s:15:\"invalid_request\";s:7:\"message\";s:32:\"Missing required parameter: code\";s:4:\"date\";i:1518191026;}i:15;a:4:{s:7:\"section\";s:22:\"init_auth0_oauth/token\";s:4:\"code\";s:15:\"invalid_request\";s:7:\"message\";s:32:\"Missing required parameter: code\";s:4:\"date\";i:1510299758;}i:16;a:4:{s:7:\"section\";s:38:\"WP_Auth0_Api_Client::search_connection\";s:4:\"code\";s:3:\"N/A\";s:7:\"message\";s:101:\"{\"statusCode\":401,\"error\":\"Unauthorized\",\"message\":\"Bad audience: https://elvi.eu.auth0.com/api/v2/\"}\";s:4:\"date\";i:1510067328;}i:17;a:4:{s:7:\"section\";s:38:\"WP_Auth0_Api_Client::update_connection\";s:4:\"code\";s:3:\"N/A\";s:7:\"message\";s:60:\"{\"statusCode\":404,\"error\":\"Not Found\",\"message\":\"Not Found\"}\";s:4:\"date\";i:1510067321;}i:18;a:4:{s:7:\"section\";s:38:\"WP_Auth0_Api_Client::search_connection\";s:4:\"code\";s:3:\"N/A\";s:7:\"message\";s:101:\"{\"statusCode\":401,\"error\":\"Unauthorized\",\"message\":\"Bad audience: https://elvi.eu.auth0.com/api/v2/\"}\";s:4:\"date\";i:1510067321;}i:19;a:4:{s:7:\"section\";s:38:\"WP_Auth0_Api_Client::search_connection\";s:4:\"code\";s:3:\"N/A\";s:7:\"message\";s:101:\"{\"statusCode\":401,\"error\":\"Unauthorized\",\"message\":\"Bad audience: https://elvi.eu.auth0.com/api/v2/\"}\";s:4:\"date\";i:1510065775;}}', 'yes'),
(4975, 'widget_media_gallery', 'a:1:{s:12:\"_multiwidget\";i:1;}', 'yes'),
(6053, 'wbcr_inp_cache_options', 'a:3:{s:25:\"factory_dismissed_notices\";b:0;s:44:\"factory_404_plugin_activated_wbcr_insert_php\";i:1536833730;s:17:\"upgrade_up_to_201\";i:1;}', 'yes'),
(6054, 'wbcr_inp_factory_404_plugin_activated_wbcr_insert_php', '1536833730', 'yes'),
(6055, 'factory_plugin_versions', 'a:1:{s:15:\"wbcr_insert_php\";s:10:\"free-2.0.6\";}', 'yes'),
(6056, 'wbcr_inp_upgrade_up_to_201', '1', 'yes'),
(6427, 'rlrsssl_options', 'a:14:{s:12:\"site_has_ssl\";b:0;s:4:\"hsts\";b:0;s:22:\"htaccess_warning_shown\";b:0;s:19:\"review_notice_shown\";b:0;s:25:\"ssl_success_message_shown\";b:0;s:26:\"autoreplace_insecure_links\";b:1;s:17:\"plugin_db_version\";s:5:\"3.1.2\";s:5:\"debug\";b:0;s:20:\"do_not_edit_htaccess\";b:0;s:17:\"htaccess_redirect\";b:0;s:11:\"ssl_enabled\";b:0;s:19:\"javascript_redirect\";b:0;s:11:\"wp_redirect\";b:0;s:31:\"switch_mixed_content_fixer_hook\";b:0;}', 'yes'),
(6430, 'secure_auth_key', '@g^s;n{F)~ZM7.T_Ui_%Eu7}YR_&A&?d,l @.M~>}^dP#b1TNdL-yCbJtkB(`wJR', 'no'),
(6431, 'secure_auth_salt', 'BV)/9ZL+^+!BG8LYmaL$|,ee*,o3QqSw$}.W-`*X#4h}X)1rH79Dy@EeMK!AxFQh', 'no'),
(7250, '_site_transient_timeout_browser_4f580420fc30ef32385315403354ff54', '1543331385', 'no'),
(7251, '_site_transient_browser_4f580420fc30ef32385315403354ff54', 'a:10:{s:4:\"name\";s:7:\"Firefox\";s:7:\"version\";s:4:\"63.0\";s:8:\"platform\";s:7:\"Windows\";s:10:\"update_url\";s:24:\"https://www.firefox.com/\";s:7:\"img_src\";s:44:\"http://s.w.org/images/browsers/firefox.png?1\";s:11:\"img_src_ssl\";s:45:\"https://s.w.org/images/browsers/firefox.png?1\";s:15:\"current_version\";s:2:\"56\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}', 'no'),
(7266, '_transient_is_multi_author', '0', 'yes'),
(7272, '_site_transient_timeout_browser_88948936c8355fa92108d4448c2520d0', '1543336746', 'no'),
(7273, '_site_transient_browser_88948936c8355fa92108d4448c2520d0', 'a:10:{s:4:\"name\";s:6:\"Chrome\";s:7:\"version\";s:13:\"70.0.3538.102\";s:8:\"platform\";s:7:\"Windows\";s:10:\"update_url\";s:29:\"https://www.google.com/chrome\";s:7:\"img_src\";s:43:\"http://s.w.org/images/browsers/chrome.png?1\";s:11:\"img_src_ssl\";s:44:\"https://s.w.org/images/browsers/chrome.png?1\";s:15:\"current_version\";s:2:\"18\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;s:6:\"mobile\";b:0;}', 'no'),
(7346, 'ossdl_off_cdn_url', 'http://budgeting.s3platform.eu', 'yes'),
(7347, 'ossdl_off_blog_url', 'http://budgeting.s3platform.eu', 'yes'),
(7348, 'ossdl_off_include_dirs', 'wp-content,wp-includes', 'yes'),
(7349, 'ossdl_off_exclude', '.php', 'yes'),
(7350, 'ossdl_cname', '', 'yes'),
(7351, 'wp_super_cache_index_detected', '1', 'no'),
(7352, 'wpsupercache_start', '1542884249', 'yes'),
(7353, 'wpsupercache_count', '0', 'yes'),
(7355, 'supercache_stats', 'a:3:{s:9:\"generated\";i:1542884275;s:10:\"supercache\";a:5:{s:7:\"expired\";i:0;s:6:\"cached\";i:0;s:5:\"fsize\";i:0;s:11:\"cached_list\";a:0:{}s:12:\"expired_list\";a:0:{}}s:7:\"wpcache\";a:5:{s:7:\"expired\";i:0;s:6:\"cached\";i:0;s:5:\"fsize\";i:0;s:11:\"cached_list\";a:0:{}s:12:\"expired_list\";a:0:{}}}', 'yes'),
(7364, '_site_transient_update_core', 'O:8:\"stdClass\":4:{s:7:\"updates\";a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:6:\"latest\";s:8:\"download\";s:65:\"https://downloads.wordpress.org/release/en_GB/wordpress-4.9.8.zip\";s:6:\"locale\";s:5:\"en_GB\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:65:\"https://downloads.wordpress.org/release/en_GB/wordpress-4.9.8.zip\";s:10:\"no_content\";b:0;s:11:\"new_bundled\";b:0;s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"4.9.8\";s:7:\"version\";s:5:\"4.9.8\";s:11:\"php_version\";s:5:\"5.2.4\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"4.7\";s:15:\"partial_version\";s:0:\"\";}}s:12:\"last_checked\";i:1543188458;s:15:\"version_checked\";s:5:\"4.9.8\";s:12:\"translations\";a:0:{}}', 'no'),
(7365, '_site_transient_update_plugins', 'O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1543188458;s:7:\"checked\";a:5:{s:18:\"auth0/WP_Auth0.php\";s:5:\"3.8.1\";s:25:\"insert-php/insert_php.php\";s:5:\"2.0.6\";s:47:\"really-simple-ssl/rlrsssl-really-simple-ssl.php\";s:5:\"3.1.2\";s:25:\"sucuri-scanner/sucuri.php\";s:6:\"1.8.18\";s:27:\"wp-super-cache/wp-cache.php\";s:5:\"1.6.4\";}s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:5:{s:18:\"auth0/WP_Auth0.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:19:\"w.org/plugins/auth0\";s:4:\"slug\";s:5:\"auth0\";s:6:\"plugin\";s:18:\"auth0/WP_Auth0.php\";s:11:\"new_version\";s:5:\"3.8.1\";s:3:\"url\";s:36:\"https://wordpress.org/plugins/auth0/\";s:7:\"package\";s:48:\"https://downloads.wordpress.org/plugin/auth0.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:58:\"https://ps.w.org/auth0/assets/icon-256x256.png?rev=1194871\";s:2:\"1x\";s:58:\"https://ps.w.org/auth0/assets/icon-128x128.png?rev=1194871\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:61:\"https://ps.w.org/auth0/assets/banner-1544x500.png?rev=1194880\";s:2:\"1x\";s:60:\"https://ps.w.org/auth0/assets/banner-772x250.png?rev=1194880\";}s:11:\"banners_rtl\";a:0:{}}s:25:\"insert-php/insert_php.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:24:\"w.org/plugins/insert-php\";s:4:\"slug\";s:10:\"insert-php\";s:6:\"plugin\";s:25:\"insert-php/insert_php.php\";s:11:\"new_version\";s:5:\"2.0.6\";s:3:\"url\";s:41:\"https://wordpress.org/plugins/insert-php/\";s:7:\"package\";s:53:\"https://downloads.wordpress.org/plugin/insert-php.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:63:\"https://ps.w.org/insert-php/assets/icon-256x256.jpg?rev=1891898\";s:2:\"1x\";s:63:\"https://ps.w.org/insert-php/assets/icon-128x128.jpg?rev=1891898\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:66:\"https://ps.w.org/insert-php/assets/banner-1544x500.jpg?rev=1891898\";s:2:\"1x\";s:65:\"https://ps.w.org/insert-php/assets/banner-772x250.jpg?rev=1891898\";}s:11:\"banners_rtl\";a:0:{}}s:47:\"really-simple-ssl/rlrsssl-really-simple-ssl.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:31:\"w.org/plugins/really-simple-ssl\";s:4:\"slug\";s:17:\"really-simple-ssl\";s:6:\"plugin\";s:47:\"really-simple-ssl/rlrsssl-really-simple-ssl.php\";s:11:\"new_version\";s:5:\"3.1.2\";s:3:\"url\";s:48:\"https://wordpress.org/plugins/really-simple-ssl/\";s:7:\"package\";s:66:\"https://downloads.wordpress.org/plugin/really-simple-ssl.3.1.2.zip\";s:5:\"icons\";a:1:{s:2:\"1x\";s:70:\"https://ps.w.org/really-simple-ssl/assets/icon-128x128.png?rev=1782452\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:72:\"https://ps.w.org/really-simple-ssl/assets/banner-772x250.jpg?rev=1881345\";}s:11:\"banners_rtl\";a:0:{}}s:25:\"sucuri-scanner/sucuri.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:28:\"w.org/plugins/sucuri-scanner\";s:4:\"slug\";s:14:\"sucuri-scanner\";s:6:\"plugin\";s:25:\"sucuri-scanner/sucuri.php\";s:11:\"new_version\";s:6:\"1.8.18\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/sucuri-scanner/\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/plugin/sucuri-scanner.1.8.18.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:67:\"https://ps.w.org/sucuri-scanner/assets/icon-256x256.png?rev=1235419\";s:2:\"1x\";s:67:\"https://ps.w.org/sucuri-scanner/assets/icon-128x128.png?rev=1235419\";}s:7:\"banners\";a:1:{s:2:\"1x\";s:69:\"https://ps.w.org/sucuri-scanner/assets/banner-772x250.png?rev=1235419\";}s:11:\"banners_rtl\";a:0:{}}s:27:\"wp-super-cache/wp-cache.php\";O:8:\"stdClass\":9:{s:2:\"id\";s:28:\"w.org/plugins/wp-super-cache\";s:4:\"slug\";s:14:\"wp-super-cache\";s:6:\"plugin\";s:27:\"wp-super-cache/wp-cache.php\";s:11:\"new_version\";s:5:\"1.6.4\";s:3:\"url\";s:45:\"https://wordpress.org/plugins/wp-super-cache/\";s:7:\"package\";s:63:\"https://downloads.wordpress.org/plugin/wp-super-cache.1.6.4.zip\";s:5:\"icons\";a:2:{s:2:\"2x\";s:67:\"https://ps.w.org/wp-super-cache/assets/icon-256x256.png?rev=1095422\";s:2:\"1x\";s:67:\"https://ps.w.org/wp-super-cache/assets/icon-128x128.png?rev=1095422\";}s:7:\"banners\";a:2:{s:2:\"2x\";s:70:\"https://ps.w.org/wp-super-cache/assets/banner-1544x500.png?rev=1082414\";s:2:\"1x\";s:69:\"https://ps.w.org/wp-super-cache/assets/banner-772x250.png?rev=1082414\";}s:11:\"banners_rtl\";a:0:{}}}}', 'no'),
(7366, '_site_transient_update_themes', 'O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1543188458;s:7:\"checked\";a:2:{s:8:\"onlineS3\";s:5:\"1.0.0\";s:13:\"twentysixteen\";s:3:\"1.5\";}s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}}', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `wp_postmeta`
--

CREATE TABLE `wp_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wp_postmeta`
--

INSERT INTO `wp_postmeta` (`meta_id`, `post_id`, `meta_key`, `meta_value`) VALUES
(1, 2, '_wp_page_template', 'default'),
(2, 4, '_edit_last', '1'),
(3, 4, '_edit_lock', '1496404353:1'),
(4, 10, '_wp_attached_file', '2017/11/logo.png'),
(5, 10, '_wp_attachment_metadata', 'a:5:{s:5:\"width\";i:353;s:6:\"height\";i:258;s:4:\"file\";s:16:\"2017/11/logo.png\";s:5:\"sizes\";a:2:{s:9:\"thumbnail\";a:4:{s:4:\"file\";s:16:\"logo-150x150.png\";s:5:\"width\";i:150;s:6:\"height\";i:150;s:9:\"mime-type\";s:9:\"image/png\";}s:6:\"medium\";a:4:{s:4:\"file\";s:16:\"logo-300x219.png\";s:5:\"width\";i:300;s:6:\"height\";i:219;s:9:\"mime-type\";s:9:\"image/png\";}}s:10:\"image_meta\";a:12:{s:8:\"aperture\";s:1:\"0\";s:6:\"credit\";s:0:\"\";s:6:\"camera\";s:0:\"\";s:7:\"caption\";s:0:\"\";s:17:\"created_timestamp\";s:1:\"0\";s:9:\"copyright\";s:0:\"\";s:12:\"focal_length\";s:1:\"0\";s:3:\"iso\";s:1:\"0\";s:13:\"shutter_speed\";s:1:\"0\";s:5:\"title\";s:0:\"\";s:11:\"orientation\";s:1:\"0\";s:8:\"keywords\";a:0:{}}}'),
(6, 1, '_edit_lock', '1531820124:1'),
(7, 1, '_edit_last', '1');

-- --------------------------------------------------------

--
-- Table structure for table `wp_posts`
--

CREATE TABLE `wp_posts` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `post_author` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `guid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(1, 1, '2017-06-02 11:52:08', '2017-06-02 10:52:08', 'Welcome to WordPress. This is your first post. Edit or delete it, then start writing!', 'Hello world!', '', 'private', 'open', 'open', '', 'hello-world', '', '', '2018-07-17 10:37:47', '2018-07-17 09:37:47', '', 0, 'http://budgeting.s3platform.eu/?p=1', 0, 'post', '', 1),
(2, 1, '2017-06-02 11:52:08', '2017-06-02 10:52:08', 'This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:\n\n<blockquote>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my blog. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</blockquote>\n\n...or something like this:\n\n<blockquote>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</blockquote>\n\nAs a new WordPress user, you should go to <a href=\"http://budgeting.s3platform.eu/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!', 'Sample Page', '', 'publish', 'closed', 'open', '', 'sample-page', '', '', '2017-06-02 11:52:08', '2017-06-02 10:52:08', '', 0, 'http://budgeting.s3platform.eu/?page_id=2', 0, 'page', '', 0),
(4, 1, '2017-06-02 12:12:30', '2017-06-02 11:12:30', '[insert_php]include \'php-src/templates/home.php\';[/insert_php]', 'home', '', 'publish', 'closed', 'closed', '', 'home', '', '', '2017-06-02 12:12:30', '2017-06-02 11:12:30', '', 0, 'http://budgeting.s3platform.eu/?page_id=4', 0, 'page', '', 0),
(5, 1, '2017-06-02 12:12:30', '2017-06-02 11:12:30', '[insert_php]include \'php-src/templates/home.php\';[/insert_php]', 'home', '', 'inherit', 'closed', 'closed', '', '4-revision-v1', '', '', '2017-06-02 12:12:30', '2017-06-02 11:12:30', '', 4, 'http://budgeting.s3platform.eu/2017/06/02/4-revision-v1/', 0, 'revision', '', 0),
(6, 1, '2017-06-02 12:20:46', '2017-06-02 11:20:46', '', 'favicon', '', 'inherit', 'open', 'closed', '', 'favicon', '', '', '2017-06-02 12:20:46', '2017-06-02 11:20:46', '', 0, 'http://budgeting.s3platform.eu/favicon/', 0, 'attachment', '', 0),
(10, 1, '2017-11-07 14:33:30', '2017-11-07 14:33:30', '', 'logo', '', 'inherit', 'open', 'closed', '', 'logo', '', '', '2017-11-07 14:33:30', '2017-11-07 14:33:30', '', 0, 'http://budgeting.s3platform.eu/wp-content/uploads/2017/11/logo.png', 0, 'attachment', 'image/png', 0),
(12, 1, '2018-07-17 10:37:47', '2018-07-17 09:37:47', 'Welcome to WordPress. This is your first post. Edit or delete it, then start writing!', 'Hello world!', '', 'inherit', 'closed', 'closed', '', '1-revision-v1', '', '', '2018-07-17 10:37:47', '2018-07-17 09:37:47', '', 1, 'http://budgeting.s3platform.eu/2018/07/17/1-revision-v1/', 0, 'revision', '', 0),
(17, 1, '2018-11-20 15:09:45', '0000-00-00 00:00:00', '', 'Auto Draft', '', 'auto-draft', 'open', 'open', '', '', '', '', '2018-11-20 15:09:45', '0000-00-00 00:00:00', '', 0, 'https://budgeting.s3platform.eu/?p=17', 0, 'post', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `wp_termmeta`
--

CREATE TABLE `wp_termmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wp_terms`
--

CREATE TABLE `wp_terms` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wp_terms`
--

INSERT INTO `wp_terms` (`term_id`, `name`, `slug`, `term_group`) VALUES
(1, 'Uncategorised', 'uncategorised', 0);

-- --------------------------------------------------------

--
-- Table structure for table `wp_term_relationships`
--

CREATE TABLE `wp_term_relationships` (
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wp_term_relationships`
--

INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`) VALUES
(1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `wp_term_taxonomy`
--

CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wp_term_taxonomy`
--

INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES
(1, 1, 'category', '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `wp_usermeta`
--

CREATE TABLE `wp_usermeta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wp_users`
--

CREATE TABLE `wp_users` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `budget`
--
ALTER TABLE `budget`
  ADD PRIMARY KEY (`id`),
  ADD KEY `budget_fin_idx` (`finance`),
  ADD KEY `budget_fund_idx` (`funding`),
  ADD KEY `budget_inter_idx` (`inter`),
  ADD KEY `budget_object_idx` (`object`),
  ADD KEY `measure_fk_idx` (`measure`);

--
-- Indexes for table `budget_plan`
--
ALTER TABLE `budget_plan`
  ADD PRIMARY KEY (`plan_id`),
  ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`);

--
-- Indexes for table `budget_val`
--
ALTER TABLE `budget_val`
  ADD PRIMARY KEY (`budget_id`,`year`);

--
-- Indexes for table `finance`
--
ALTER TABLE `finance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `funding`
--
ALTER TABLE `funding`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inter`
--
ALTER TABLE `inter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inter_type_idx` (`type`);

--
-- Indexes for table `inter_types`
--
ALTER TABLE `inter_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `measure`
--
ALTER TABLE `measure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prio_measure_idx` (`prio_id`);

--
-- Indexes for table `nuts0`
--
ALTER TABLE `nuts0`
  ADD PRIMARY KEY (`code`),
  ADD UNIQUE KEY `label_UNIQUE` (`label`);

--
-- Indexes for table `nuts1`
--
ALTER TABLE `nuts1`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `objective`
--
ALTER TABLE `objective`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `priority`
--
ALTER TABLE `priority`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prio_user_fk_idx` (`user_id`);

--
-- Indexes for table `prio_years`
--
ALTER TABLE `prio_years`
  ADD PRIMARY KEY (`year`,`user_id`),
  ADD KEY `user_fk_idx` (`user_id`);

--
-- Indexes for table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`code`),
  ADD UNIQUE KEY `label_UNIQUE` (`label`),
  ADD KEY `reg_count_fk_idx` (`country_id`);

--
-- Indexes for table `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `wp_comments`
--
ALTER TABLE `wp_comments`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `comment_post_ID` (`comment_post_ID`),
  ADD KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  ADD KEY `comment_date_gmt` (`comment_date_gmt`),
  ADD KEY `comment_parent` (`comment_parent`),
  ADD KEY `comment_author_email` (`comment_author_email`(10));

--
-- Indexes for table `wp_links`
--
ALTER TABLE `wp_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `link_visible` (`link_visible`);

--
-- Indexes for table `wp_options`
--
ALTER TABLE `wp_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_name` (`option_name`);

--
-- Indexes for table `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `wp_posts`
--
ALTER TABLE `wp_posts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `post_name` (`post_name`(191)),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  ADD KEY `post_parent` (`post_parent`),
  ADD KEY `post_author` (`post_author`);

--
-- Indexes for table `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `wp_terms`
--
ALTER TABLE `wp_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `slug` (`slug`(191)),
  ADD KEY `name` (`name`(191));

--
-- Indexes for table `wp_term_relationships`
--
ALTER TABLE `wp_term_relationships`
  ADD PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  ADD KEY `term_taxonomy_id` (`term_taxonomy_id`);

--
-- Indexes for table `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  ADD PRIMARY KEY (`term_taxonomy_id`),
  ADD UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- Indexes for table `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  ADD PRIMARY KEY (`umeta_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `wp_users`
--
ALTER TABLE `wp_users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_login_key` (`user_login`),
  ADD KEY `user_nicename` (`user_nicename`),
  ADD KEY `user_email` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `budget`
--
ALTER TABLE `budget`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budget_plan`
--
ALTER TABLE `budget_plan`
  MODIFY `plan_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `funding`
--
ALTER TABLE `funding`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `measure`
--
ALTER TABLE `measure`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `priority`
--
ALTER TABLE `priority`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wp_commentmeta`
--
ALTER TABLE `wp_commentmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wp_comments`
--
ALTER TABLE `wp_comments`
  MODIFY `comment_ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wp_links`
--
ALTER TABLE `wp_links`
  MODIFY `link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wp_options`
--
ALTER TABLE `wp_options`
  MODIFY `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7449;

--
-- AUTO_INCREMENT for table `wp_postmeta`
--
ALTER TABLE `wp_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `wp_posts`
--
ALTER TABLE `wp_posts`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `wp_termmeta`
--
ALTER TABLE `wp_termmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wp_terms`
--
ALTER TABLE `wp_terms`
  MODIFY `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wp_term_taxonomy`
--
ALTER TABLE `wp_term_taxonomy`
  MODIFY `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `wp_usermeta`
--
ALTER TABLE `wp_usermeta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wp_users`
--
ALTER TABLE `wp_users`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `budget`
--
ALTER TABLE `budget`
  ADD CONSTRAINT `measure_fk` FOREIGN KEY (`measure`) REFERENCES `measure` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `budget_val`
--
ALTER TABLE `budget_val`
  ADD CONSTRAINT `budget_fk` FOREIGN KEY (`budget_id`) REFERENCES `budget` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inter`
--
ALTER TABLE `inter`
  ADD CONSTRAINT `inter_type` FOREIGN KEY (`type`) REFERENCES `inter_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `measure`
--
ALTER TABLE `measure`
  ADD CONSTRAINT `prio_measure` FOREIGN KEY (`prio_id`) REFERENCES `priority` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `priority`
--
ALTER TABLE `priority`
  ADD CONSTRAINT `prio_user_fk` FOREIGN KEY (`user_id`) REFERENCES `budget_plan` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prio_years`
--
ALTER TABLE `prio_years`
  ADD CONSTRAINT `user_fk` FOREIGN KEY (`user_id`) REFERENCES `budget_plan` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
