---
title: Faker - Synthetic Data
contents-list: h1,h2
section: python
---

See [Faker](https://faker.readthedocs.io/en/master/index.html).

# Locales and Initialization

```python
# Locale: ar_AA, ar_AE, ar_BH, ar_EG, ar_JO, ar_PS, ar_SA, az_AZ, bg_BG, bn_BD, bs_BA,
#         cs_CZ, da_DK, de_AT, de_CH, de_DE, dk_DK, el_CY, el_GR, en_AU, en_BD, en_CA,
#         en_GB, en_IE, en_IN, en_NZ, en_PH, en_TH, en_US, es_AR, es_CA, es_CL, es_CO,
#         es_ES, es_MX, et_EE, fa_IR, fi_FI, fil_PH, fr_BE, fr_CA, fr_CH, fr_FR, fr_QC,
#         ga_IE, he_IL, hi_IN, hr_HR, hu_HU, hy_AM, id_ID, it_CH, it_IT, ja_JP, ka_GE,
#         ko_KR, lb_LU, lt_LT, lv_LV, mt_MT, ne_NP, nl_BE, nl_NL, no_NO, or_IN, pl_PL,
#         pt_BR, pt_PT, ro_RO, ru_RU, sk_SK, sl_SI, sq_AL, sv_SE, ta_IN, th_TH, tl_PH,
#         tr_TR, tw_GH, uk_UA, vi_VN, zh_CN, zh_TW, zu_ZA

from faker import Faker

# Instantiate with multiple locales.
f = Faker(['en_GB', 'es_ES'])

# Seed to get same "random" value each run.
Faker.seed(1)
```

# Standard Generators

```python
# [unique.]address() -> str
print("address:", f.unique.address())

# [unique.]administrative_unit() -> str
print("administrative_unit:", f.unique.administrative_unit())

# [unique.]building_number() -> str
print("building_number:", f.unique.building_number())

# [unique.]city() -> str
print("city:", f.unique.city())

# [unique.]city_prefix() -> str
print("city_prefix:", f.unique.city_prefix())

# [unique.]city_suffix() -> str
print("city_suffix:", f.unique.city_suffix())

# [unique.]country() -> str
print("country:", f.unique.country())

# [unique.]country_code(representation: str = 'alpha-2') -> str
print("country_code:", f.unique.country_code())

# [unique.]county() -> str
print("county:", f.unique.county())

# [unique.]current_country() -> str
print("current_country:", f.unique.current_country())

# [unique.]current_country_code() -> str
print("current_country_code:", f.unique.current_country_code())

# [unique.]postcode() -> str
print("postcode:", f.unique.postcode())

# [unique.]secondary_address() -> str
print("secondary_address:", f.unique.secondary_address())

# [unique.]street_address() -> str
print("street_address:", f.unique.street_address())

# [unique.]street_name() -> str
print("street_name:", f.unique.street_name())

# [unique.]street_suffix() -> str
print("street_suffix:", f.unique.street_suffix())

# [unique.]license_plate() -> str
print("license_plate:", f.unique.license_plate())

# [unique.]vin() -> str
print("vin:", f.unique.vin())

# [unique.]aba() -> str
print("aba:", f.unique.aba())

# [unique.]bank_country() -> str
print("bank_country:", f.unique.bank_country())

# [unique.]bban() -> str
print("bban:", f.unique.bban())

# [unique.]iban() -> str
print("iban:", f.unique.iban())

# [unique.]swift(length: int | None = None, primary: bool = False, use_dataset: bool = False) -> str
print("swift:", f.unique.swift())

# [unique.]swift11(primary: bool = False, use_dataset: bool = False) -> str
print("swift11:", f.unique.swift11())

# [unique.]swift8(use_dataset: bool = False) -> str
print("swift8:", f.unique.swift8())

# [unique.]ascii_company_email() -> str
print("ascii_company_email:", f.unique.ascii_company_email())

# [unique.]ascii_email() -> str
print("ascii_email:", f.unique.ascii_email())

# [unique.]ascii_free_email() -> str
print("ascii_free_email:", f.unique.ascii_free_email())

# [unique.]ascii_safe_email() -> str
print("ascii_safe_email:", f.unique.ascii_safe_email())

# [unique.]company_email() -> str
print("company_email:", f.unique.company_email())

# [unique.]dga(year: int | None = None, month: int | None = None, day: int | None = None, tld: str | None = None, length: int | None = None) -> str
print("dga:", f.unique.dga())

# [unique.]domain_name(levels: int = 1) -> str
print("domain_name:", f.unique.domain_name())

# [unique.]domain_word() -> str
print("domain_word:", f.unique.domain_word())

# [unique.]email(safe: bool = True, domain: str | None = None) -> str
print("email:", f.unique.email())

# [unique.]free_email() -> str
print("free_email:", f.unique.free_email())

# [unique.]free_email_domain() -> str
print("free_email_domain:", f.unique.free_email_domain())

# [unique.]hostname(levels: int = 1) -> str
print("hostname:", f.unique.hostname())

# [unique.]http_method() -> str
print("http_method:", f.unique.http_method())

# [unique.]http_status_code(include_unassigned: bool = True) -> int
print("http_status_code:", f.unique.http_status_code())

# [unique.]iana_id() -> str
print("iana_id:", f.unique.iana_id())

# [unique.]image_url(width: int | None = None, height: int | None = None, placeholder_url: str | None = None) -> str
print("image_url:", f.unique.image_url())

# [unique.]ipv4(network: bool = False, address_class: str | None = None, private: str | None = None) -> str
print("ipv4:", f.unique.ipv4())

# [unique.]ipv4_network_class() -> str
print("ipv4_network_class:", f.unique.ipv4_network_class())

# [unique.]ipv4_private(network: bool = False, address_class: str | None = None) -> str
print("ipv4_private:", f.unique.ipv4_private())

# [unique.]ipv4_public(network: bool = False, address_class: str | None = None) -> str
print("ipv4_public:", f.unique.ipv4_public())

# [unique.]ipv6(network: bool = False) -> str
print("ipv6:", f.unique.ipv6())

# [unique.]mac_address(multicast: bool = False) -> str
print("mac_address:", f.unique.mac_address())

# [unique.]nic_handle(suffix: str = 'FAKE') -> str
print("nic_handle:", f.unique.nic_handle())

# [unique.]nic_handles(count: int = 1, suffix: str = '????') -> List[str]
print("nic_handles:", f.nic_handles())

# [unique.]port_number(is_system: bool = False, is_user: bool = False, is_dynamic: bool = False) -> int
print("port_number:", f.unique.port_number())

# [unique.]ripe_id() -> str
print("ripe_id:", f.unique.ripe_id())

# [unique.]safe_domain_name() -> str
print("safe_domain_name:", f.unique.safe_domain_name())

# [unique.]safe_email() -> str
print("safe_email:", f.unique.safe_email())

# [unique.]slug(value: str | None = None) -> str
print("slug:", f.unique.slug())

# [unique.]tld() -> str
print("tld:", f.unique.tld())

# [unique.]uri(schemes: List[str] | None = None, deep: int | None = None) -> str
print("uri:", f.unique.uri())

# [unique.]uri_extension() -> str
print("uri_extension:", f.unique.uri_extension())

# [unique.]uri_page() -> str
print("uri_page:", f.unique.uri_page())

# [unique.]uri_path(deep: int | None = None) -> str
print("uri_path:", f.unique.uri_path())

# [unique.]url(schemes: List[str] | None = None) -> str
print("url:", f.unique.url())

# [unique.]user_name() -> str
print("user_name:", f.unique.user_name())

# [unique.]first_name() -> str
print("first_name:", f.unique.first_name())

# [unique.]first_name_female() -> str
print("first_name_female:", f.unique.first_name_female())

# [unique.]first_name_male() -> str
print("first_name_male:", f.unique.first_name_male())

# [unique.]first_name_nonbinary() -> str
print("first_name_nonbinary:", f.unique.first_name_nonbinary())

# [unique.]language_name() -> str
print("language_name:", f.unique.language_name())

# [unique.]last_name() -> str
print("last_name:", f.unique.last_name())

# [unique.]last_name_female() -> str
print("last_name_female:", f.unique.last_name_female())

# [unique.]last_name_male() -> str
print("last_name_male:", f.unique.last_name_male())

# [unique.]last_name_nonbinary() -> str
print("last_name_nonbinary:", f.unique.last_name_nonbinary())

# [unique.]name() -> str
print("name:", f.unique.name())

# [unique.]name_female() -> str
print("name_female:", f.unique.name_female())

# [unique.]name_male() -> str
print("name_male:", f.unique.name_male())

# [unique.]name_nonbinary() -> str
print("name_nonbinary:", f.unique.name_nonbinary())

# [unique.]prefix() -> str
print("prefix:", f.unique.prefix())

# [unique.]prefix_female() -> str
print("prefix_female:", f.unique.prefix_female())

# [unique.]prefix_male() -> str
print("prefix_male:", f.unique.prefix_male())

# [unique.]prefix_nonbinary() -> str
print("prefix_nonbinary:", f.unique.prefix_nonbinary())

# [unique.]suffix() -> str
print("suffix:", f.unique.suffix())

# [unique.]suffix_female() -> str
print("suffix_female:", f.unique.suffix_female())

# [unique.]suffix_male() -> str
print("suffix_male:", f.unique.suffix_male())

# [unique.]suffix_nonbinary() -> str
print("suffix_nonbinary:", f.unique.suffix_nonbinary())

# [unique.]cellphone_number() -> str
print("cellphone_number:", f.unique.cellphone_number())

# [unique.]country_calling_code() -> str
print("country_calling_code:", f.unique.country_calling_code())

# [unique.]msisdn() -> str
print("msisdn:", f.unique.msisdn())

# [unique.]phone_number() -> str
print("phone_number:", f.unique.phone_number())

# [unique.]ssn() -> str
print("ssn:", f.unique.ssn())

# [unique.]vat_id() -> str
print("vat_id:", f.unique.vat_id())
```

# Date Generators

```python
# [unique.]century() -> str
print("century:", century())

# [unique.]date(pattern: str = '%Y-%m-%d', end_datetime: date | datetime | timedelta | str | int | None = None) -> str
print("date:", date())

# [unique.]date_between(start_date: date | datetime | timedelta | str | int = '-30y', end_date: date | datetime | timedelta | str | int = 'today') -> date
print("date_between:", date_between())

# [unique.]date_between_dates(date_start: date | datetime | timedelta | str | int | None = None, date_end: date | datetime | timedelta | str | int | None = None) -> date
print("date_between_dates:", date_between_dates())

# [unique.]date_object(end_datetime: datetime | None = None) -> date
print("date_object:", date_object())

# [unique.]date_of_birth(tzinfo: tzinfo | None = None, minimum_age: int = 0, maximum_age: int = 115) -> date
print("date_of_birth:", date_of_birth())

# [unique.]date_this_century(before_today: bool = True, after_today: bool = False) -> date
print("date_this_century:", date_this_century())

# [unique.]date_this_decade(before_today: bool = True, after_today: bool = False) -> date
print("date_this_decade:", date_this_decade())

# [unique.]date_this_month(before_today: bool = True, after_today: bool = False) -> date
print("date_this_month:", date_this_month())

# [unique.]date_this_year(before_today: bool = True, after_today: bool = False) -> date
print("date_this_year:", date_this_year())

# [unique.]date_time(tzinfo: tzinfo | None = None, end_datetime: date | datetime | timedelta | str | int | None = None) -> datetime
print("date_time:", date_time())

# [unique.]date_time_ad(tzinfo: tzinfo | None = None, end_datetime: date | datetime | timedelta | str | int | None = None, start_datetime: date | datetime | timedelta | str | int | None = None) -> datetime
print("date_time_ad:", date_time_ad())

# [unique.]date_time_between(start_date: date | datetime | timedelta | str | int = '-30y', end_date: date | datetime | timedelta | str | int = 'now', tzinfo: tzinfo | None = None) -> datetime
print("date_time_between:", date_time_between())

# [unique.]date_time_between_dates(datetime_start: date | datetime | timedelta | str | int | None = None, datetime_end: date | datetime | timedelta | str | int | None = None, tzinfo: tzinfo | None = None) -> datetime
print("date_time_between_dates:", date_time_between_dates())

# [unique.]date_time_this_century(before_now: bool = True, after_now: bool = False, tzinfo: tzinfo | None = None) -> datetime
print("date_time_this_century:", date_time_this_century())

# [unique.]date_time_this_decade(before_now: bool = True, after_now: bool = False, tzinfo: tzinfo | None = None) -> datetime
print("date_time_this_decade:", date_time_this_decade())

# [unique.]date_time_this_month(before_now: bool = True, after_now: bool = False, tzinfo: tzinfo | None = None) -> datetime
print("date_time_this_month:", date_time_this_month())

# [unique.]date_time_this_year(before_now: bool = True, after_now: bool = False, tzinfo: tzinfo | None = None) -> datetime
print("date_time_this_year:", date_time_this_year())

# [unique.]day_of_month() -> str
print("day_of_month:", day_of_month())

# [unique.]day_of_week() -> str
print("day_of_week:", day_of_week())

# [unique.]future_date(end_date: date | datetime | timedelta | str | int = '+30d', tzinfo: tzinfo | None = None) -> date
print("future_date:", future_date())

# [unique.]future_datetime(end_date: date | datetime | timedelta | str | int = '+30d', tzinfo: tzinfo | None = None) -> datetime
print("future_datetime:", future_datetime())

# [unique.]iso8601(tzinfo: tzinfo | None = None, end_datetime: date | datetime | timedelta | str | int | None = None, sep: str = 'T', timespec: str = 'auto') -> str
print("iso8601:", iso8601())

# [unique.]month() -> str
print("month:", month())

# [unique.]month_name() -> str
print("month_name:", month_name())

# [unique.]past_date(start_date: date | datetime | timedelta | str | int = '-30d', tzinfo: tzinfo | None = None) -> date
print("past_date:", past_date())

# [unique.]past_datetime(start_date: date | datetime | timedelta | str | int = '-30d', tzinfo: tzinfo | None = None) -> datetime
print("past_datetime:", past_datetime())

# [unique.]pytimezone(*args: Any, **kwargs: Any) -> tzinfo | None
print("pytimezone:", pytimezone())

# [unique.]time(pattern: str = '%H:%M:%S', end_datetime: date | datetime | timedelta | str | int | None = None) -> str
print("time:", time())

# [unique.]time_delta(end_datetime: date | datetime | timedelta | str | int | None = None) -> timedelta
print("time_delta:", time_delta())

# [unique.]time_object(end_datetime: date | datetime | timedelta | str | int | None = None) -> time
print("time_object:", time_object())

# [unique.]time_series(start_date: date | datetime | timedelta | str | int = '-30d', end_date: date | datetime | timedelta | str | int = 'now', precision: float | None = None, distrib: Callable[[datetime], float] | None = None, tzinfo: tzinfo | None = None) -> Iterator[Tuple[datetime, Any]]
print("time_series:", time_series())

# [unique.]timezone() -> str
print("timezone:", timezone())

# [unique.]unix_time(end_datetime: date | datetime | timedelta | str | int | None = None, start_datetime: date | datetime | timedelta | str | int | None = None) -> float
print("unix_time:", unix_time())

# [unique.]year() -> str
print("year:", year())
```

